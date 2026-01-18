using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;

namespace MyPlayerInput
{
	public class ActionButtonsManager : IDisposable
	{
		private InputModel inputModel_;

		private List<ActionButtonHierarchy> pressedButtons_;

		private UnityEvent unityEvent_;

		public ActionButtonsManager()
		{
			SingletonManager.Get<InputModel>(out inputModel_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			pressedButtons_ = new List<ActionButtonHierarchy>();
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
		}

		public void AddButton(ActionButtonHierarchy button, Action pressHadnler = null, Action releaseHadnler = null)
		{
			button.click = new ClickUtility<ActionButtonHierarchy>(button);
			button.click.Pressed += HandlePress;
			button.button.gameObject.tag = "NGUIIgnoreLock";
			button.button.autoDisableOnPress = true;
			button.button.onPress += button.click.Press;
			if (pressHadnler != null)
			{
				button.click.Pressed += delegate
				{
					pressHadnler();
				};
			}
			if (releaseHadnler != null)
			{
				button.click.Released += delegate
				{
					releaseHadnler();
				};
			}
		}

		public void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
		}

		private void HandlePress(ActionButtonHierarchy button)
		{
			button.inputInstance = inputModel_.CurrentInstance;
			pressedButtons_.Add(button);
			inputModel_.CurrentInstance.Used = true;
		}

		private void UnityUpdate()
		{
			pressedButtons_.IterateAndRemove(Check);
		}

		private bool Check(int i)
		{
			ActionButtonHierarchy actionButtonHierarchy = pressedButtons_[i];
			if (!actionButtonHierarchy.inputInstance.Pressed)
			{
				actionButtonHierarchy.click.Release();
				actionButtonHierarchy.button.Reset();
				actionButtonHierarchy.inputInstance.Used = false;
				return true;
			}
			return false;
		}
	}
}
