using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;

public class UiRoller : IDisposable
{
	private int index_;

	private UISprite sprite_;

	private string[] sprites_;

	private UnityTimer timer_;

	public UIWidget Widget { get; private set; }

	public UiRoller(UIWidget parent)
	{
		PrefabsManager prefabsManager = SingletonManager.Get<PrefabsManager>();
		sprite_ = prefabsManager.InstantiateIn<UISprite>("UIRoller", parent.transform);
		sprite_.SetAnchor(parent.gameObject, 0, 0, 0, 0);
		UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
		timer_ = unityTimerManager.SetTimer(0.1f);
		timer_.repeat = true;
		timer_.Completeted += HandleTimerCompleteted;
		string text = sprite_.spriteName.Substring(0, sprite_.spriteName.Length - 1);
		sprite_.depth = parent.depth + 1;
		sprites_ = new string[12];
		for (int i = 0; i < sprites_.Length; i++)
		{
			sprites_[i] = text + i;
		}
		Widget = sprite_;
	}

	public void Dispose()
	{
		if (timer_ != null)
		{
			timer_.Stop();
		}
	}

	private void HandleTimerCompleteted()
	{
		if (sprite_ == null)
		{
			Dispose();
		}
		else if (sprite_.gameObject.activeInHierarchy)
		{
			index_++;
			if (index_ >= sprites_.Length)
			{
				index_ = 0;
			}
			sprite_.spriteName = sprites_[index_];
		}
	}
}
