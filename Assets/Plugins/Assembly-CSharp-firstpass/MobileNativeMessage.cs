using System;

public class MobileNativeMessage
{
	public Action OnComplete = delegate
	{
	};

	public MobileNativeMessage(string title, string message)
	{
		init(title, message, "Ok");
	}

	public MobileNativeMessage(string title, string message, string ok)
	{
		init(title, message, ok);
	}

	private void init(string title, string message, string ok)
	{
		MNAndroidMessage mNAndroidMessage = MNAndroidMessage.Create(title, message, ok);
		mNAndroidMessage.OnComplete = (Action<MNDialogResult>)Delegate.Combine(mNAndroidMessage.OnComplete, new Action<MNDialogResult>(OnCompleteListener));
	}

	private void OnCompleteListener(MNDialogResult res)
	{
		OnComplete();
	}
}
