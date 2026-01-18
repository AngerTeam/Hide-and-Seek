using System;
using System.Collections;
using UnityEngine;

public class WPN_TextureLoader : MonoBehaviour
{
	private string _url;

	public event Action<Texture2D> TextureLoaded = delegate
	{
	};

	public static WPN_TextureLoader Create()
	{
		return new GameObject("WPN_TextureLoader").AddComponent<WPN_TextureLoader>();
	}

	public void LoadTexture(string url)
	{
		_url = url;
		StartCoroutine(LoadCoroutin());
	}

	private IEnumerator LoadCoroutin()
	{
		WWW www = new WWW(_url);
		yield return www;
		this.TextureLoaded(www.texture);
		UnityEngine.Object.Destroy(base.gameObject);
	}
}
