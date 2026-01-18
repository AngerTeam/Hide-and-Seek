using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using UnityEngine;

namespace SoundsModule
{
	public class Sound
	{
		public AudioClip clip;

		public SoundsEntries entry;

		public FileHolder fileHolder;

		private string path;

		public Sound(SoundsEntries entry)
		{
			this.entry = entry;
		}

		public void Load(TaskQueue queue)
		{
			FilesManager singlton;
			SingletonManager.Get<FilesManager>(out singlton);
			string fileUrl = ((!CompileConstants.MOBILE) ? entry.GetFullnamePath() : entry.GetFullnameMobilePath());
			fileHolder = singlton.AddLoadAudioTask(fileUrl, queue);
		}

		public void LoadAndPlay(Action action)
		{
			QueueManager singlton;
			SingletonManager.Get<QueueManager>(out singlton);
			UnityThreadQueue queue = singlton.AddUnityThreadQueue();
			Load(queue);
			singlton.AddTask(UpdateClip, queue);
			singlton.AddTask(action, queue);
		}

		public override string ToString()
		{
			return string.Format("{0} {1} {2}", entry.title, entry.filename, clip);
		}

		public void UpdateClip()
		{
			clip = fileHolder.audioClip;
		}

		internal void Play2D(AudioSource source2D, float volume, bool loaded = false)
		{
			if (clip == null)
			{
				if (loaded)
				{
					Log.Warning("Unable to load sound {0} ({1})", entry.title, entry.id);
				}
				else
				{
					LoadAndPlay(delegate
					{
						Play2D(source2D, volume, true);
					});
				}
			}
			else
			{
				source2D.spatialBlend = 0f;
				source2D.volume = volume;
				source2D.clip = clip;
				source2D.Play();
			}
		}

		internal void Play3D(AudioSource source3D, Vector3 position, float volume, bool loaded = false)
		{
			if (clip == null)
			{
				if (loaded)
				{
					Log.Warning("Unable to load sound {0} ({1})", entry.title, entry.id);
				}
				else
				{
					LoadAndPlay(delegate
					{
						Play3D(source3D, position, volume, true);
					});
				}
			}
			else
			{
				source3D.spatialBlend = 1f;
				source3D.transform.position = position;
				source3D.volume = volume;
				source3D.clip = clip;
				source3D.Play();
			}
		}
	}
}
