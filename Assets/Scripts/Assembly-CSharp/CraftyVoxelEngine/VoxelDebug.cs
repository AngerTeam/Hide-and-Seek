using System.Text;
using CraftyEngine.Infrastructure;
using NguiTools;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelDebug : PermanentSingleton
	{
		public const bool ENABLED = false;

		private UnityEvent unityEvent_;

		private PrefabsManager prefabsManager_;

		private RaycastManager raycastManager_;

		private VoxelEngine voxelEngine_;

		private VoxelDebugScreenHierarchy hierarchy_;

		public bool active;

		private StringBuilder builder_;

		public float previousTime;

		public VoxelDebug()
		{
			active = false;
			builder_ = new StringBuilder();
		}

		public override void Init()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			SingletonManager.Get<RaycastManager>(out raycastManager_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			prefabsManager_.Load("CraftyVoxelEngineRuntimePrefabsHolder");
			hierarchy_ = prefabsManager_.Instantiate<VoxelDebugScreenHierarchy>("VoxelDebugScreen");
			if (hierarchy_.container != null)
			{
				NguiManager singlton;
				SingletonManager.Get<NguiManager>(out singlton);
				hierarchy_.container.SetAnchor(singlton.UiRoot.gameObject, 0, 0, 0, 0);
			}
			hierarchy_.lightColorLabel.text = string.Empty;
			hierarchy_.debugInfoLabel.text = string.Empty;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			unityEvent_ = null;
		}

		private string FormatColor(Color32 light)
		{
			return string.Format("[{0:X2}{1:X2}{2:X2}FF]{0:X2}{1:X2}{2:X2}{3:X2}[-]", light.r, light.g, light.b, light.a);
		}

		public void Update()
		{
			if (!active)
			{
				hierarchy_.lightColorLabel.text = string.Empty;
				hierarchy_.debugInfoLabel.text = string.Empty;
				return;
			}
			builder_.Length = 0;
			VoxelRaycastHit voxelRaycastHit = raycastManager_.VoxelRayCastWrap(-1f);
			if (voxelRaycastHit.success)
			{
				if (Input.GetKeyDown(KeyCode.C))
				{
					CopyKeyToBuffer(voxelRaycastHit.Full);
				}
				builder_.AppendFormat("LookAt: {0}\n", voxelRaycastHit.Full);
				Voxel voxel;
				if (voxelEngine_.core.GetVoxel(voxelRaycastHit.Full, out voxel))
				{
					builder_.AppendLine(voxel.ToString());
					hierarchy_.lightColorLabel.text = FormatColor(voxel.Light);
					VoxelData data;
					if (voxelEngine_.Settings.GetData(voxel.Value, out data))
					{
						builder_.AppendLine(data.ToString());
					}
				}
				hierarchy_.lightColorLabel.text += "\n";
				if (voxelEngine_.core.GetVoxel(voxelRaycastHit.Free, out voxel))
				{
					hierarchy_.lightColorLabel.text += FormatColor(voxel.Light);
				}
				VoxelRegion region = voxelEngine_.Manager.GetRegion(voxelRaycastHit.Full);
				builder_.AppendLine(region.ToString());
			}
			else
			{
				hierarchy_.lightColorLabel.text = string.Empty;
			}
			hierarchy_.debugInfoLabel.text = builder_.ToString();
		}

		private void CopyKeyToBuffer(VoxelKey key)
		{
			TextEditor textEditor = new TextEditor();
			textEditor.text = string.Format("{0};{1};{2}", key.x, key.y, key.z);
			textEditor.SelectAll();
			textEditor.Copy();
		}
	}
}
