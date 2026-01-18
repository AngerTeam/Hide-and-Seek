using System;
using SA.Common.Models;
using UnityEngine;

public class GC_Player
{
	private string _playerId = string.Empty;

	private string _name = string.Empty;

	private string _avatarUrl = string.Empty;

	private Texture2D _avatar;

	public string PlayerId
	{
		get
		{
			return _playerId;
		}
	}

	public string Name
	{
		get
		{
			return _name;
		}
	}

	public string AvatarUrl
	{
		get
		{
			return _avatarUrl;
		}
	}

	public Texture2D Avatar
	{
		get
		{
			return _avatar;
		}
	}

	public event Action<Texture2D> AvatarLoaded = delegate
	{
	};

	public void LoadAvatar()
	{
		if (_avatar != null)
		{
			this.AvatarLoaded(_avatar);
			return;
		}
		Debug.Log("Amazon Player Avatar Started to Load!");
		WWWTextureLoader wWWTextureLoader = WWWTextureLoader.Create();
		wWWTextureLoader.OnLoad += OnProfileImageLoaded;
		wWWTextureLoader.LoadTexture(_avatarUrl);
	}

	private void OnProfileImageLoaded(Texture2D texture)
	{
		Debug.Log("Amazon Player OnProfileImageLoaded" + texture);
		_avatar = texture;
		this.AvatarLoaded(_avatar);
	}
}
