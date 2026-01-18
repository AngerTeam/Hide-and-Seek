using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils.Unity;
using InventoryViewModule;
using PlayerModule;
using UnityEngine;

namespace CraftyGameEngine.Player
{
	public class ActorRotator : IDisposable
	{
		private bool enable_;

		private InputModel inputManager_;

		private PlayerStatsModel model_;

		private bool nguiDrag_;

		private float ratio = 1f;

		private Vector3 startRotation_;

		private UnityEvent unityEvent_;

		private List<Func<GameObject, Component>> nguiComponentsCheck_;

		public ActorRotator(PlayerStatsModel model)
		{
			model_ = model;
			SingletonManager.Get<InputModel>(out inputManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			UICamera.onPress = (UICamera.BoolDelegate)Delegate.Combine(UICamera.onPress, new UICamera.BoolDelegate(HandleNguiPress));
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			nguiComponentsCheck_ = new List<Func<GameObject, Component>>();
			nguiComponentsCheck_.Add(GameObjectUtils.GetComponentInParents<InventorySlotHierarchy>);
			nguiComponentsCheck_.Add(GameObjectUtils.GetComponentInParents<UIScrollView>);
			nguiComponentsCheck_.Add(GameObjectUtils.GetComponentInParents<UIDragScrollView>);
		}

		public void Dispose()
		{
			enable_ = false;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			UICamera.onPress = (UICamera.BoolDelegate)Delegate.Remove(UICamera.onPress, new UICamera.BoolDelegate(HandleNguiPress));
		}

		private void HandleNguiPress(GameObject go, bool press)
		{
			if (!press)
			{
				nguiDrag_ = false;
				return;
			}
			for (int i = 0; i < nguiComponentsCheck_.Count; i++)
			{
				Component component = nguiComponentsCheck_[i](go);
				if (component != null)
				{
					nguiDrag_ = true;
					break;
				}
			}
		}

		private void Update()
		{
			InputInstance inputInstance = inputManager_.InputIntances[0];
			if (inputInstance == null)
			{
				return;
			}
			if (inputInstance.Pressed && !inputInstance.IsNguiClick && !UICursor.customCursor && !UICamera.isDragging && !nguiDrag_)
			{
				if (!enable_)
				{
					startRotation_ = model_.Rotation;
					enable_ = true;
				}
			}
			else
			{
				enable_ = false;
			}
			if (enable_)
			{
				float y = (inputInstance.StartPressPosition.x - inputInstance.CurrentPosition.x) * ratio;
				model_.SetPosition(model_.Position, startRotation_ + new Vector3(0f, y, 0f), false);
			}
		}
	}
}
