using System;
using UnityEngine;

public class MNPopup : MonoBehaviour
{
	public string title;

	public string message;

	public Action<MNDialogResult> OnComplete = delegate
	{
	};
}
