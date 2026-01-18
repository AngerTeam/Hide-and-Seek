using System.Collections.Generic;
using UnityEngine;

namespace SoundsModule
{
	public class SoundGroup
	{
		public List<Sound> sounds;

		public SoundGroup()
		{
			sounds = new List<Sound>();
		}

		public Sound GetRandomClip()
		{
			return sounds[Random.Range(0, sounds.Count)];
		}

		public Sound GetClip(int index)
		{
			return sounds[index];
		}
	}
}
