using System;
using Extensions;
using UnityEngine;

[RequireComponent(typeof(UISprite))]
public class UICursor : MonoBehaviour
{
	public static UICursor instance;

	public static bool customCursor;

	public Camera uiCamera;

	private Transform mTrans;

	private UISprite mSprite;

	private UILabel mLabel;

	private UIAtlas mAtlas;

	private string mSpriteName;

	public static event Action Cleared;

	public static event Action Seted;

	public event Action SelectionCleared;

	public void InitCursor()
	{
		if (instance != null)
		{
			instance = null;
		}
		instance = this;
		mTrans = base.transform;
		mSprite = GetComponentInChildren<UISprite>();
		mLabel = GetComponentInChildren<UILabel>();
		if (uiCamera == null)
		{
			uiCamera = NGUITools.FindCameraForLayer(base.gameObject.layer);
		}
		if (mSprite != null)
		{
			mAtlas = mSprite.atlas;
			mSpriteName = mSprite.spriteName;
			if (mSprite.depth < 100)
			{
				mSprite.depth = 100;
			}
		}
		if (mLabel.depth < 100)
		{
			mLabel.depth = 100;
		}
	}

	private void Update()
	{
		Vector3 mousePosition = Input.mousePosition;
		if (mTrans == null)
		{
			return;
		}
		if (uiCamera != null)
		{
			mousePosition.x = Mathf.Clamp01(mousePosition.x / (float)Screen.width);
			mousePosition.y = Mathf.Clamp01(mousePosition.y / (float)Screen.height);
			mTrans.position = uiCamera.ViewportToWorldPoint(mousePosition);
			if (uiCamera.orthographic)
			{
				Vector3 localPosition = mTrans.localPosition;
				localPosition.x = Mathf.Round(localPosition.x);
				localPosition.y = Mathf.Round(localPosition.y);
				mTrans.localPosition = localPosition;
			}
		}
		else
		{
			mousePosition.x -= (float)Screen.width * 0.5f;
			mousePosition.y -= (float)Screen.height * 0.5f;
			mousePosition.x = Mathf.Round(mousePosition.x);
			mousePosition.y = Mathf.Round(mousePosition.y);
			mTrans.localPosition = mousePosition;
		}
	}

	public static void Clear()
	{
		if (instance != null && (bool)instance.mSprite)
		{
			Set(instance.mAtlas, instance.mSpriteName, string.Empty);
			if (instance.SelectionCleared != null)
			{
				instance.SelectionCleared();
			}
			UICursor.Cleared.SafeInvoke();
		}
		customCursor = false;
	}

	public static void Set(UIAtlas atlas, string sprite, string name)
	{
		if (instance != null && instance.mSprite != null)
		{
			customCursor = true;
			instance.mSprite.atlas = atlas;
			instance.mSprite.spriteName = sprite;
			instance.mLabel.text = name;
			instance.Update();
			UICursor.Seted.SafeInvoke();
		}
	}
}
