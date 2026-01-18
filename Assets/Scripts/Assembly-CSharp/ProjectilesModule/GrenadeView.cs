using System;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace ProjectilesModule
{
	public class GrenadeView : IDisposable
	{
		private readonly Transform transform_;

		public Vector3 Position
		{
			get
			{
				return transform_.position;
			}
			set
			{
				transform_.position = value;
			}
		}

		public GrenadeView(Transform parent = null)
		{
			PrefabsManager singlton;
			SingletonManager.Get<PrefabsManager>(out singlton);
			transform_ = singlton.Instantiate<Transform>("GrenadeTest");
			transform_.SetParent(parent);
		}

		public void Dispose()
		{
			UnityEngine.Object.Destroy(transform_.gameObject);
		}

		public void SetName(string name)
		{
			if (!string.IsNullOrEmpty(name))
			{
				transform_.name = name;
			}
		}

		public void OnHit()
		{
		}

		public void OnStop()
		{
		}

		public void OnExplode()
		{
		}
	}
}
