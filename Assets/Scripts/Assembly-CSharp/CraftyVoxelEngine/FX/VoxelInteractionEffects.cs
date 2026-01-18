using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using UnityEngine;

namespace CraftyVoxelEngine.FX
{
	public class VoxelInteractionEffects : PermanentSingleton
	{
		public static bool debugEnabled = true;

		private FXManager fxManager_;

		private UnityEvent unityEvent_;

		private VoxelInteraction voxelInteraction_;

		private List<Vector2> copyCache_;

		private VoxelEngine voxelEngine_;

		public int defaultHitSound;

		public VoxelCursor voxelCursor { get; private set; }

		public bool IsVoxelInHand
		{
			get
			{
				return voxelCursor.isVoxelInHand;
			}
			set
			{
				if (voxelCursor != null)
				{
					voxelCursor.isVoxelInHand = value;
				}
			}
		}

		public VoxelInteractionEffects()
		{
			copyCache_ = new List<Vector2>();
			voxelCursor = new VoxelCursor();
		}

		public override void Init()
		{
			GetSingleton<FXManager>(out fxManager_);
			GetSingleton<UnityEvent>(out unityEvent_);
			GetSingleton<VoxelEngine>(out voxelEngine_);
			GetSingleton<VoxelInteraction>(out voxelInteraction_);
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			voxelInteraction_.controller.VoxelDestroyed += HandleVoxelDestroyed;
			voxelInteraction_.controller.VoxelHit += HandleVoxelHit;
			voxelCursor.Init();
		}

		private void HandleVoxelHit(VoxelEventArgs obj)
		{
			MakeEffects(voxelInteraction_.model.point, voxelInteraction_.model.value, false);
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
			voxelInteraction_.controller.VoxelDestroyed -= HandleVoxelDestroyed;
			voxelInteraction_.controller.VoxelHit -= HandleVoxelHit;
		}

		public void MakeEffects(VoxelKey globalKey, ushort voxelId, bool big, bool addVoxelSound = true)
		{
			MakeEffects(globalKey.ToVector() + Vector3.one * 0.5f, voxelId, big, addVoxelSound);
		}

		public void MakeEffects(Vector3 point, ushort voxelId, bool big, bool addVoxelSound = true)
		{
			if (!debugEnabled || voxelId == 0)
			{
				return;
			}
			for (int i = 0; i < 6; i++)
			{
				Vector2 firstTextureUv = voxelEngine_.GetFirstTextureUv(voxelId, i);
				if (!copyCache_.Contains(firstTextureUv))
				{
					fxManager_.ParticleController.Emit(point, big, firstTextureUv);
					copyCache_.Add(firstTextureUv);
				}
				if (!big)
				{
					break;
				}
			}
			copyCache_.Clear();
			VoxelData data;
			if (addVoxelSound && voxelEngine_.GetVoxelData(voxelId, out data))
			{
				int id = ((data.SoundGroupDig <= 0) ? defaultHitSound : data.SoundGroupDig);
				SoundProvider.Play(id, true, point, 1f);
			}
		}

		private void HandleVoxelDestroyed(VoxelEventArgs e)
		{
			if (voxelInteraction_ != null)
			{
				MakeEffects(voxelInteraction_.model.globalKey, voxelInteraction_.model.value, true);
			}
		}

		private void UnityUpdate()
		{
			VoxelRaycastHit rayHit = voxelInteraction_.model.rayHit;
			if (rayHit.success)
			{
				voxelCursor.Set(rayHit);
			}
			else
			{
				voxelCursor.HideCursor();
			}
		}
	}
}
