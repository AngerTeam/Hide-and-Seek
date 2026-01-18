using System;
using UnityEngine;

[Serializable]
public class OfflineContentSettings
{
	public string[] paths = new string[1];

	public static OfflineContentSettings Get()
	{
		TextAsset textAsset = Resources.Load<TextAsset>("OfflineContentPaths");
		if (textAsset != null)
		{
			string text = textAsset.text;
			return JsonUtility.FromJson<OfflineContentSettings>(text);
		}
		return new OfflineContentSettings();
	}
}
