using System;
using System.Collections.Generic;
using CraftyEngine;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Infrastructure.SingletonManagerCore;
using CraftyEngine.Sounds;
using CraftyEngine.Utils;
using UnityEngine;

namespace SoundsModule
{
	public class SoundManager : PermanentSingleton
	{
		private bool musicOn_ = true;

		public bool soundOn = true;

		public float musicSwitchDelay = 5f;

		private AudioSource ambientSource_;

		private ThreadObjectPool<AudioSourceHolder> audio2DPool_;

		private ThreadObjectPool<AudioSourceHolder> audio3DPool_;

		private bool disposed_;

		private Dictionary<int, SoundGroup> groups_;

		private Dictionary<int, Sound> sounds_;

		private CameraManager cameraManager_;

		private PersistanceUserSettings userSettings_;

		private UnityTimerManager unityTimerManager_;

		private FileHolder ambientfile_;

		public bool MusicOn
		{
			get
			{
				return musicOn_;
			}
			set
			{
				if (musicOn_ != value)
				{
					musicOn_ = value;
					HandleMusicOnChanged();
				}
			}
		}

		public SoundManager()
		{
			AdjustableSettings.Register<SoundSettings>();
		}

		private void HandleMusicOnChanged()
		{
			if (!(ambientSource_ == null) && !(ambientSource_.clip == null))
			{
				if (musicOn_)
				{
					ambientSource_.volume = SoundProvider.MusicVolume;
					ambientSource_.Play();
				}
				else
				{
					ambientSource_.volume = 0f;
					ambientSource_.Stop();
				}
			}
		}

		public override void Init()
		{
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings_);
			MusicOn = userSettings_.musicOn;
			soundOn = userSettings_.soundOn;
			sounds_ = new Dictionary<int, Sound>();
			groups_ = new Dictionary<int, SoundGroup>();
			InitAmbient();
			SingletonManager.PhaseCompleted += OnPhaseComplited;
		}

		public void Play(SoundInfo sound)
		{
			if (!string.IsNullOrEmpty(sound.fileUrl))
			{
				SetAmbientGroup(sound.fileUrl);
			}
			else if (sound.ambient)
			{
				if (sound.group)
				{
					SetAmbientGroup(sound.soundId);
				}
				else
				{
					SetAmbientSound(sound.soundId);
				}
			}
			else if (sound.group)
			{
				if (sound.position.HasValue)
				{
					PlayGroupSound3D(sound.position.Value, sound.soundId, sound.volume);
				}
				else
				{
					PlayGroupSound2D(sound.soundId, sound.volume);
				}
			}
			else if (sound.position.HasValue)
			{
				PlaySound3D(sound.position.Value, sound.soundId, sound.volume);
			}
			else
			{
				PlaySound2D(sound.soundId, sound.volume);
			}
		}

		private void OnPhaseComplited(SingletonPhase phase, int layer)
		{
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
		}

		public override void Dispose()
		{
			disposed_ = true;
			groups_.Clear();
			groups_ = null;
			sounds_.Clear();
			sounds_ = null;
		}

		public void InitAmbient()
		{
			GameObject gameObject = new GameObject("SoundManagerAmbient");
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
			ambientSource_ = gameObject.AddComponent<AudioSource>();
			ambientSource_.spatialBlend = 0f;
			ambientSource_.loop = true;
			ambientSource_.volume = 1f;
			audio2DPool_ = new ThreadObjectPool<AudioSourceHolder>();
			audio3DPool_ = new ThreadObjectPool<AudioSourceHolder>();
		}

		public override void OnDataLoaded()
		{
			musicSwitchDelay = 15f;
			InitGroups();
		}

		public bool TryGetSound(int soundId, out Sound sound)
		{
			sound = null;
			if (disposed_)
			{
				return false;
			}
			try
			{
				if (sounds_ != null)
				{
					return sounds_.TryGetValue(soundId, out sound);
				}
			}
			catch (Exception ex)
			{
				Log.Warning(ex.ToString());
			}
			return false;
		}

		internal void UpdateVolume()
		{
			if (MusicOn)
			{
				if (ambientSource_ != null)
				{
					if (ambientSource_.volume <= 0f)
					{
						ambientSource_.Play();
					}
					ambientSource_.volume = SoundProvider.MusicVolume;
				}
			}
			else
			{
				ambientSource_.volume = 0f;
				ambientSource_.Stop();
			}
		}

		private void InitGroups()
		{
			foreach (SoundsEntries value3 in SoundsContentMap.Sounds.Values)
			{
				Sound value = new Sound(value3);
				sounds_.Add(value3.id, value);
			}
			foreach (SoundGroupsEntries value4 in SoundsContentMap.SoundGroups.Values)
			{
				SoundGroup value2 = new SoundGroup();
				groups_.Add(value4.id, value2);
			}
			foreach (SoundGroupLinksEntries value5 in SoundsContentMap.SoundGroupLinks.Values)
			{
				try
				{
					groups_[value5.group_id].sounds.Add(sounds_[value5.sound_id]);
				}
				catch (Exception ex)
				{
					Log.Warning(string.Format("Cant link sound {0} into group {1}\n\n{2}", value5.sound_id, value5.group_id, ex.Message));
				}
			}
		}

		private void SetAmbientGroup(int groupId)
		{
			Sound sound;
			if (MusicOn && TryGetRandomSound(groupId, out sound))
			{
				sound.Play2D(ambientSource_, SoundProvider.MusicVolume);
			}
		}

		private void SetAmbientSound(int soundId)
		{
			Sound sound;
			if (MusicOn && TryGetSound(soundId, out sound))
			{
				sound.Play2D(ambientSource_, SoundProvider.MusicVolume);
			}
		}

		private void SetAmbientGroup(string soundUrl)
		{
			QueueManager queueManager = SingletonManager.Get<QueueManager>(2);
			FilesManager filesManager = SingletonManager.Get<FilesManager>(2);
			ambientfile_ = filesManager.AddLoadAudioTask(soundUrl);
			queueManager.AddTask(PlayLoadedAmbient);
		}

		private void PlayLoadedAmbient()
		{
			ambientSource_.spatialBlend = 0f;
			ambientSource_.volume = SoundProvider.MusicVolume;
			ambientSource_.clip = ambientfile_.audioClip;
			ambientSource_.Play();
		}

		public void StopAmbient()
		{
			if (ambientSource_ != null && ambientSource_.clip != null)
			{
				ambientSource_.Stop();
			}
		}

		public void PlaySound2D(int soundId, float volume = 1f)
		{
			Sound sound;
			if (soundOn && TryGetSound(soundId, out sound))
			{
				Play2D(volume, sound);
			}
		}

		public void PlayGroupSound2D(int groupId, float volume = 1f)
		{
			Sound sound;
			if (soundOn && TryGetRandomSound(groupId, out sound))
			{
				Play2D(volume, sound);
			}
		}

		public void PlaySound3D(Vector3 position, int soundId, float volume = 1f)
		{
			Sound sound;
			if (soundOn && TryGetSound(soundId, out sound))
			{
				Play3D(position, volume, sound);
			}
		}

		public void PlayGroupSound3D(Vector3 position, int groupId, float volume = 1f)
		{
			Sound sound;
			if (soundOn && TryGetRandomSound(groupId, out sound))
			{
				Play3D(position, volume, sound);
			}
		}

		private void Play2D(float volume, Sound sound)
		{
			if (soundOn && ActionDebugLocker.audio)
			{
				AudioSourceHolder holder = audio2DPool_.Get();
				holder.source.gameObject.SetActive(true);
				float num = ((!(sound.clip != null)) ? 0f : sound.clip.length);
				UnityTimer unityTimer = unityTimerManager_.SetTimer((num == 0f) ? 20f : num);
				unityTimer.Completeted += delegate
				{
					Release(audio2DPool_, holder);
				};
				sound.Play2D(holder.source, volume * SoundProvider.effectsVolume);
			}
		}

		private bool TestDistance(Vector3 position)
		{
			return cameraManager_ != null && (position - cameraManager_.PlayerCamera.transform.position).magnitude < (float)SoundsContentMap.SoundSettings.CombatSoundDistance;
		}

		private void Play3D(Vector3 position, float volume, Sound sound)
		{
			if (soundOn && ActionDebugLocker.audio && TestDistance(position))
			{
				AudioSourceHolder holder = audio3DPool_.Get();
				holder.source.gameObject.SetActive(true);
				float num = ((!(sound.clip != null)) ? 0f : sound.clip.length);
				UnityTimer unityTimer = unityTimerManager_.SetTimer((num == 0f) ? 20f : num);
				unityTimer.Completeted += delegate
				{
					Release(audio3DPool_, holder);
				};
				sound.Play3D(holder.source, position, volume * SoundProvider.effectsVolume);
			}
		}

		private void Release(ThreadObjectPool<AudioSourceHolder> pool, AudioSourceHolder holder)
		{
			pool.Release(holder);
			holder.source.gameObject.SetActive(false);
		}

		private bool TryGetRandomSound(int groupId, out Sound sound)
		{
			sound = null;
			if (disposed_)
			{
				return false;
			}
			try
			{
				SoundGroup value;
				if (groups_ != null && groups_.TryGetValue(groupId, out value))
				{
					sound = value.GetRandomClip();
					return sound != null;
				}
			}
			catch (Exception ex)
			{
				Log.Warning(ex.ToString());
			}
			return false;
		}
	}
}
