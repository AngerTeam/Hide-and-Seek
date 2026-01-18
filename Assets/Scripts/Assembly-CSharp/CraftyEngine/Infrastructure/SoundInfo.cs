using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public struct SoundInfo
	{
		public float volume;

		public int soundId;

		public bool group;

		public bool ambient;

		public Vector3? position;

		public string fileUrl;

		public SoundInfo(int soundId)
		{
			volume = 1f;
			this.soundId = soundId;
			group = false;
			ambient = false;
			position = null;
			fileUrl = null;
		}
	}
}
