using System;
using UnityEngine;

public class MNUseExample : MNFeaturePreview
{
	public string appleId = string.Empty;

	public string androidAppUrl = "market://details?id=com.google.earth";

	private void Awake()
	{
	}

	private void OnGUI()
	{
		UpdateToStartPos();
		GUI.Label(new Rect(StartX, StartY, Screen.width, 40f), "Native Pop Ups", style);
		StartY += YLableStep;
		if (GUI.Button(new Rect(StartX, StartY, buttonWidth, buttonHeight), "Rate PopUp with events"))
		{
			MobileNativeRateUs mobileNativeRateUs = new MobileNativeRateUs("Like this game?", "Please rate to support future updates!");
			mobileNativeRateUs.SetAppleId(appleId);
			mobileNativeRateUs.SetAndroidAppUrl(androidAppUrl);
			mobileNativeRateUs.OnComplete = (Action<MNDialogResult>)Delegate.Combine(mobileNativeRateUs.OnComplete, new Action<MNDialogResult>(OnRatePopUpClose));
			mobileNativeRateUs.Start();
		}
		StartX += XButtonStep;
		if (GUI.Button(new Rect(StartX, StartY, buttonWidth, buttonHeight), "Dialog PopUp"))
		{
			MobileNativeDialog mobileNativeDialog = new MobileNativeDialog("Dialog Titile", "Dialog message");
			mobileNativeDialog.OnComplete = (Action<MNDialogResult>)Delegate.Combine(mobileNativeDialog.OnComplete, new Action<MNDialogResult>(OnDialogClose));
			Invoke("Dismiss", 2f);
		}
		StartX += XButtonStep;
		if (GUI.Button(new Rect(StartX, StartY, buttonWidth, buttonHeight), "Message PopUp"))
		{
			MobileNativeMessage mobileNativeMessage = new MobileNativeMessage("Message Titile", "Message message");
			mobileNativeMessage.OnComplete = (Action)Delegate.Combine(mobileNativeMessage.OnComplete, new Action(OnMessageClose));
		}
		StartY += YButtonStep;
		StartX = XStartPos;
		if (GUI.Button(new Rect(StartX, StartY, buttonWidth, buttonHeight), "Show Prealoder"))
		{
			MNP.ShowPreloader("Title", "Message");
			Invoke("OnPreloaderTimeOut", 3f);
		}
		StartX += XButtonStep;
		if (GUI.Button(new Rect(StartX, StartY, buttonWidth, buttonHeight), "Hide Prealoder"))
		{
			MNP.HidePreloader();
		}
	}

	private void Dismiss()
	{
		Debug.Log("DIALOG DISMISS");
		MNAndroidNative.dismissDialog();
	}

	private void OnPreloaderTimeOut()
	{
		MNP.HidePreloader();
	}

	private void OnRatePopUpClose(MNDialogResult result)
	{
		switch (result)
		{
		case MNDialogResult.RATED:
			Debug.Log("Rate Option pickied");
			break;
		case MNDialogResult.REMIND:
			Debug.Log("Remind Option pickied");
			break;
		case MNDialogResult.DECLINED:
			Debug.Log("Declined Option pickied");
			break;
		}
		new MobileNativeMessage("Result", result.ToString() + " button pressed");
	}

	private void OnDialogClose(MNDialogResult result)
	{
		switch (result)
		{
		case MNDialogResult.YES:
			Debug.Log("Yes button pressed");
			break;
		case MNDialogResult.NO:
			Debug.Log("No button pressed");
			break;
		}
		new MobileNativeMessage("Result", result.ToString() + " button pressed");
	}

	private void OnMessageClose()
	{
		new MobileNativeMessage("Result", "Message Closed");
	}
}
