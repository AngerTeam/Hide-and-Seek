using UnityEngine;

namespace SoundsModule
{
	public class AudioSourceHolder
	{
		public AudioSource source;

		private static int id_;

		private static GameObject parent_;

		public AudioSourceHolder()
		{
			id_++;
			if (parent_ == null)
			{
				parent_ = new GameObject("AudioSourceHolder");
				Object.DontDestroyOnLoad(parent_);
			}
			GameObject gameObject = new GameObject("AudioSource-" + id_);
			gameObject.transform.SetParent(parent_.transform, false);
			source = gameObject.AddComponent<AudioSource>();
			source.spatialBlend = 0f;
			source.loop = false;
			source.volume = 1f;
			source.maxDistance = 15f;
		}
	}
}
