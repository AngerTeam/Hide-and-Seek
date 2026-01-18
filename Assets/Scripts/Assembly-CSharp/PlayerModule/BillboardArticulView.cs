using ArticulViewModule;
using CraftyEngine.Infrastructure;
using NguiTools;
using UnityEngine;

namespace PlayerModule
{
	public class BillboardArticulView : ArticulViewBase
	{
		private NguiManager NGUIManager_;

		private float texWidth_;

		private float texHeight_;

		private Material material;

		private UnityEvent unityEvent_;

		private Transform playerCamera;

		public override bool IsBillboard
		{
			get
			{
				return true;
			}
		}

		public bool Ready { get; private set; }

		public string Bundle { get; private set; }

		public override void Render(Transform container, int ArtikulID)
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			if (NGUIManager_ == null)
			{
				SingletonManager.Get<NguiManager>(out NGUIManager_);
			}
			if (NGUIManager_ != null)
			{
				UISpriteData sprite = NGUIManager_.GetSprite(ArtikulID.ToString());
				if (sprite == null)
				{
					Log.Warning("Unable to get sprite for Articul {0}", ArtikulID.ToString());
					return;
				}
				if (material == null)
				{
					Shader shader = Shader.Find("Unlit/Transparent Colored");
					material = new Material(shader);
				}
				Texture atlasTexture = NGUIManager_.AtlasTexture;
				material.mainTexture = atlasTexture;
				texWidth_ = atlasTexture.width;
				texHeight_ = atlasTexture.height;
				float x = (float)sprite.x / texWidth_;
				float y = 1f - (float)sprite.y / texHeight_;
				float x2 = (float)(sprite.x + sprite.width) / texWidth_;
				float y2 = 1f - (float)(sprite.y + sprite.height) / texHeight_;
				Mesh mesh = new Mesh();
				mesh.vertices = new Vector3[4]
				{
					new Vector3(-0.5f, 0.5f, 0f),
					new Vector3(-0.5f, -0.5f, 0f),
					new Vector3(0.5f, -0.5f, 0f),
					new Vector3(0.5f, 0.5f, 0f)
				};
				mesh.uv = new Vector2[4]
				{
					new Vector2(x, y),
					new Vector2(x, y2),
					new Vector2(x2, y2),
					new Vector2(x2, y)
				};
				mesh.colors32 = new Color32[4]
				{
					Color.white,
					Color.white,
					Color.white,
					Color.white
				};
				mesh.triangles = new int[6] { 0, 1, 2, 0, 2, 3 };
				mesh.RecalculateNormals();
				base.Container = new GameObject("Articul:" + ArtikulID);
				base.Container.transform.SetParent(container, false);
				MeshFilter meshFilter = base.Container.AddComponent<MeshFilter>();
				MeshRenderer meshRenderer = base.Container.AddComponent<MeshRenderer>();
				meshRenderer.sharedMaterial = material;
				meshFilter.sharedMesh = mesh;
			}
			ReportRendered();
		}

		public override void ActivateBillboard()
		{
			CameraManager singlton;
			SingletonManager.Get<CameraManager>(out singlton);
			playerCamera = singlton.Transform;
			unityEvent_.Subscribe(UnityEventType.Update, UpdateBillboars);
		}

		private void UpdateBillboars()
		{
			if (playerCamera != null && base.Container != null)
			{
				base.Container.transform.LookAt(playerCamera.position);
			}
		}

		public override void Dispose()
		{
			if (playerCamera != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, UpdateBillboars);
			}
			Object.Destroy(base.Container);
			Object.Destroy(base.Container);
			base.Container = null;
			base.Container = null;
			material = null;
		}
	}
}
