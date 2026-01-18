using System;

public class MobileNativeRateUs
{
	public string title;

	public string message;

	public string yes;

	public string later;

	public string no;

	public string url;

	public string appleId;

	public Action<MNDialogResult> OnComplete = delegate
	{
	};

	public MobileNativeRateUs(string title, string message)
	{
		this.title = title;
		this.message = message;
		yes = "Rate app";
		later = "Later";
		no = "No, thanks";
	}

	public MobileNativeRateUs(string title, string message, string yes, string later, string no)
	{
		this.title = title;
		this.message = message;
		this.yes = yes;
		this.later = later;
		this.no = no;
	}

	public void SetAndroidAppUrl(string _url)
	{
		url = _url;
	}

	public void SetAppleId(string _appleId)
	{
		appleId = _appleId;
	}

	public void Start()
	{
		MNAndroidRateUsPopUp mNAndroidRateUsPopUp = MNAndroidRateUsPopUp.Create(title, message, url, yes, later, no);
		mNAndroidRateUsPopUp.OnComplete = (Action<MNDialogResult>)Delegate.Combine(mNAndroidRateUsPopUp.OnComplete, new Action<MNDialogResult>(OnCompleteListener));
	}

	private void OnCompleteListener(MNDialogResult res)
	{
		OnComplete(res);
	}
}
