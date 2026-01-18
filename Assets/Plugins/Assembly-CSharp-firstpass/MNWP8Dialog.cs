using UnityEngine;

public class MNWP8Dialog : MNPopup
{
	public static MNWP8Dialog Create(string title, string message)
	{
		MNWP8Dialog mNWP8Dialog = new GameObject("WP8Dialog").AddComponent<MNWP8Dialog>();
		mNWP8Dialog.title = title;
		mNWP8Dialog.message = message;
		mNWP8Dialog.init();
		return mNWP8Dialog;
	}

	public void init()
	{
	}

	public void OnOkDel()
	{
		OnComplete(MNDialogResult.YES);
		Object.Destroy(base.gameObject);
	}

	public void OnCancelDel()
	{
		OnComplete(MNDialogResult.NO);
		Object.Destroy(base.gameObject);
	}
}
