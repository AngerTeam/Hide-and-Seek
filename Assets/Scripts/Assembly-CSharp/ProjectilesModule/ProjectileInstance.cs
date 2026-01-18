using CraftyEngine.Utils;
using DG.Tweening;
using UnityEngine;

namespace ProjectilesModule
{
	public class ProjectileInstance
	{
		public GameObject gameObject;

		public ObjectPool<ProjectileInstance> pool;

		public UnityTimer timer;

		public Transform parent;

		public Tweener moveTween;
	}
}
