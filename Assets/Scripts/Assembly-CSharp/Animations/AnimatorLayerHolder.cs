using System;
using System.Collections.Generic;
using System.IO;
using CraftyBundles;
using CraftyEngine.Infrastructure.FileSystem;
using DG.Tweening;
using UnityEngine;

namespace Animations
{
	public class AnimatorLayerHolder
	{
		private List<AnimatorClipData> clips_;

		private Dictionary<string, AnimatorClipData> clipsCache_;

		public int contentId;

		private Dictionary<string, string[]> clipsByTag_;

		public Tweener blend;

		public float weight;

		public AnimatorData Data { get; private set; }

		public List<AnimatorClipData> Clips { get; private set; }

		public AnimatorLayerHolder()
		{
			Clips = new List<AnimatorClipData>();
			clips_ = new List<AnimatorClipData>();
			clipsCache_ = new Dictionary<string, AnimatorClipData>();
		}

		public void SetData(RuntimeAnimatorController controller, string data, int id)
		{
			contentId = id;
			try
			{
				Data = JsonUtility.FromJson<AnimatorData>(data);
			}
			catch (SystemException exc)
			{
				Log.Error("Unable to get animator metadata from {0}", data);
				Log.Exception(exc);
				return;
			}
			clipsCache_.Clear();
			for (int i = 0; i < Data.layers[0].states.Length; i++)
			{
				AnimatorStateData animatorStateData = Data.layers[0].states[i];
				int clip = animatorStateData.clip;
				if (clip < 0)
				{
					continue;
				}
				AnimatorClipData animatorClipData = Data.clips[clip];
				string name = animatorClipData.name;
				if (!Clips.Contains(animatorClipData))
				{
					Clips.Add(animatorClipData);
				}
				for (int j = 0; j < controller.animationClips.Length; j++)
				{
					AnimationClip animationClip = controller.animationClips[j];
					if (animationClip.name == name)
					{
						animatorClipData.clip = animationClip;
						animatorClipData.stateName = animatorStateData.name.ToLower();
						clips_.Add(animatorClipData);
						break;
					}
				}
				if (CompileConstants.EDITOR && animatorClipData.clip == null)
				{
					Log.Animation("Unable to find clip {0} in controller \n{1}", name, data);
				}
			}
		}

		public void SetData(FileHolder animationFileHolder, int id)
		{
			string text;
			RuntimeAnimatorController runtimeAnimatorController;
			if (animationFileHolder.loadedAssetBundle == null)
			{
				text = animationFileHolder.meta;
				if (text == null)
				{
					Log.Error("Unable to get animator metadata from {0}", animationFileHolder.fileGetter.Address);
					return;
				}
				runtimeAnimatorController = animationFileHolder.bundle as RuntimeAnimatorController;
				if (runtimeAnimatorController == null)
				{
					Log.Error("Unable to get animator from {0}", animationFileHolder.fileGetter.Address);
					return;
				}
			}
			else
			{
				TextAsset textAsset = animationFileHolder.loadedAssetBundle.LoadAsset<TextAsset>("meta");
				if (textAsset == null)
				{
					textAsset = animationFileHolder.loadedAssetBundle.LoadAsset<TextAsset>("animatorMeta");
				}
				if (!(textAsset != null))
				{
					Log.Error("Unable to get animator metadata from {0}", animationFileHolder.fileGetter.Address);
					return;
				}
				text = textAsset.text;
				string text2 = null;
				string[] allAssetNames = animationFileHolder.loadedAssetBundle.GetAllAssetNames();
				foreach (string text3 in allAssetNames)
				{
					if (text3.Contains(".controller"))
					{
						text2 = Path.GetFileNameWithoutExtension(text3);
					}
				}
				if (text2 == null)
				{
					Log.Error("Unable to get animator from {0}", animationFileHolder.fileGetter.Address);
					return;
				}
				runtimeAnimatorController = animationFileHolder.loadedAssetBundle.LoadAsset<RuntimeAnimatorController>(text2);
			}
			SetData(runtimeAnimatorController, text, id);
		}

		public AnimatorClipData GetClipByState(string stateTag)
		{
			stateTag = stateTag.ToLower();
			while (true)
			{
				if (clipsCache_.ContainsKey(stateTag))
				{
					return clipsCache_[stateTag];
				}
				for (int i = 0; i < clips_.Count; i++)
				{
					AnimatorClipData animatorClipData = clips_[i];
					if (animatorClipData.stateName.Contains(stateTag))
					{
						clipsCache_.Add(stateTag, animatorClipData);
						return animatorClipData;
					}
				}
				if (stateTag == "attack")
				{
					stateTag = "shoot";
					continue;
				}
				if (!(stateTag == "dig"))
				{
					break;
				}
				stateTag = "attack";
			}
			return null;
		}

		public string[] GetAllStates(string stateName)
		{
			try
			{
				if (clipsByTag_ == null)
				{
					clipsByTag_ = new Dictionary<string, string[]>();
				}
				if (clipsByTag_.ContainsKey(stateName))
				{
					return clipsByTag_[stateName];
				}
				List<string> list = new List<string>();
				AnimatorStateData[] states = Data.layers[0].states;
				foreach (AnimatorStateData animatorStateData in states)
				{
					if (animatorStateData.name.ToLower().Contains("flaunt"))
					{
						list.Add(animatorStateData.name);
					}
				}
				clipsByTag_[stateName] = ((list.Count <= 0) ? null : list.ToArray());
				return clipsByTag_[stateName];
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
			}
			return null;
		}
	}
}
