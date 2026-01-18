using System;
using CraftyVoxelEngine;
using DG.Tweening;
using PlayerModule;
using UnityEngine;

namespace HideAndSeek
{
	public class HideCastVoxelView : IDisposable
	{
		public GameObject GameObject;

		private float duration_;

		public VoxelArticulView View { get; private set; }

		public HideCastVoxelView(VoxelInstanceModel voxel, float duration)
		{
			Build((ushort)voxel.voxelId, Vector3Utils.CenterVoxel(voxel.position), duration);
			GameObject.transform.rotation = VoxelCore.GetQuaternionByRotation((byte)voxel.rotation);
		}

		public HideCastVoxelView(ushort voxelId, Vector3 position, float duration)
		{
			Build(voxelId, position, duration);
		}

		public void Build(ushort voxelId, Vector3 position, float duration)
		{
			duration_ = duration;
			GameObject = new GameObject();
			GameObject.transform.position = position;
			View = new VoxelArticulView();
			View.RenderVoxel(GameObject.transform, voxelId, "HideVoxel");
			View.RenderCompleted += OnVoxelRendered;
		}

		private void OnVoxelRendered()
		{
			Renderer[] renderers = GameObject.GetComponentsInChildren<Renderer>();
			foreach (Renderer renderer in renderers)
			{
				Texture mainTexture = renderer.material.mainTexture;
				renderer.material = Resources.Load<Material>("DissolveVoxelMaterial");
				renderer.material.mainTexture = mainTexture;
			}
			float cutoff = 1f;
			Render(renderers, 1f);
			DOTween.To(() => 1f, delegate(float a)
			{
				cutoff = a;
			}, 0f, duration_).SetEase(Ease.OutQuad).OnUpdate(delegate
			{
				Render(renderers, cutoff);
			})
				.SetEase(Ease.InQuad);
		}

		private void Render(Renderer[] renderers, float cutoff)
		{
			foreach (Renderer renderer in renderers)
			{
				if (renderer != null)
				{
					renderer.sharedMaterial.SetFloat("_Cutoff", cutoff);
				}
			}
		}

		public void Dispose()
		{
			UnityEngine.Object.Destroy(GameObject);
			View.RenderCompleted -= OnVoxelRendered;
			View.Dispose();
		}
	}
}
