using System;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;

namespace CraftyEngine.Sounds
{
	public class SoundProvider
	{
		public static float effectsVolume = 0.5f;

		private static float musicVolume_ = 0.5f;

		public static float MusicVolume
		{
			get
			{
				return musicVolume_;
			}
			set
			{
				if (value != musicVolume_)
				{
					musicVolume_ = value;
					SoundProvider.AmbinetVolumeChanged.SafeInvoke();
				}
			}
		}

		public static event Action<SoundInfo> SoundRecieved;

		public static event Action StopAmbinetRecieved;

		public static event Action AmbinetVolumeChanged;

		public static void Play(SoundInfo info)
		{
			if (SoundProvider.SoundRecieved == null)
			{
				Log.Warning("No sound player provided!");
			}
			else
			{
				SoundProvider.SoundRecieved(info);
			}
		}

		public static void Play(int id, bool group, Vector3? position = null, float volume = 1f)
		{
			SoundInfo info = default(SoundInfo);
			info.soundId = id;
			info.group = group;
			info.position = position;
			info.volume = volume;
			Play(info);
		}

		public static void PlayGroupSound2D(int groupId, float volume = 1f)
		{
			Play(groupId, true, null, volume);
		}

		public static void PlayGroupSound3D(Vector3 position, int groupId, float volume = 1f)
		{
			Play(groupId, true, position, volume);
		}

		public static void PlaySingleSound2D(int soundId)
		{
			Play(soundId, false, null, 1f);
		}

		public static void PlaySingleSound3D(Vector3 position, int soundId)
		{
			Play(soundId, false, position, 1f);
		}

		public static void SoundAmbientGroup(string fileUrl)
		{
			SoundInfo info = default(SoundInfo);
			info.fileUrl = fileUrl;
			info.ambient = true;
			info.volume = 1f;
			Play(info);
		}

		public static void SoundAmbient(int soundId)
		{
			SoundInfo info = default(SoundInfo);
			info.group = false;
			info.soundId = soundId;
			info.ambient = true;
			info.volume = 1f;
			Play(info);
		}

		public static void SoundAmbientGroup(int groupId)
		{
			SoundInfo info = default(SoundInfo);
			info.group = true;
			info.soundId = groupId;
			info.ambient = true;
			info.volume = 1f;
			Play(info);
		}

		public static void StopAmbient()
		{
			SoundProvider.StopAmbinetRecieved.SafeInvoke();
		}
	}
}
