using System;

public class MobileNativeDialog
{
	public Action<MNDialogResult> OnComplete = delegate
	{
	};

	public MobileNativeDialog(string title, string message)
	{
		init(title, message, "Yes", "No");
	}

	public MobileNativeDialog(string title, string message, string yes, string no)
	{
		init(title, message, yes, no);
	}

	private void init(string title, string message, string yes, string no)
	{
		MNAndroidDialog mNAndroidDialog = MNAndroidDialog.Create(title, message, yes, no);
		mNAndroidDialog.OnComplete = (Action<MNDialogResult>)Delegate.Combine(mNAndroidDialog.OnComplete, new Action<MNDialogResult>(OnCompleteListener));
	}

	private void OnCompleteListener(MNDialogResult res)
	{
		OnComplete(res);
	}
}
