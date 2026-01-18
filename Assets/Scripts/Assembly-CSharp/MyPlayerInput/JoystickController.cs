using CraftyEngine.Utils.Unity;
using NguiTools;
using UnityEngine;

namespace MyPlayerInput
{
	public class JoystickController
	{
		public bool enabled;

		public GameObject gameObject;

		private InputManagerNgui inputManagerNgui_;

		private readonly MoveJoystickHierarchy moveJoystickHierarchy_;

		private readonly UIRootHierarchy uiRoot;

		public JoystickController()
		{
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			NguiManager singlton2;
			SingletonManager.Get<NguiManager>(out singlton2);
			uiRoot = singlton2.UiRoot;
			singlton.Load("MyPlayerInput");
			moveJoystickHierarchy_ = singlton.InstantiateNGUIIn<MoveJoystickHierarchy>("UIMoveJoystick", uiRoot.MoveJoystickContainer.gameObject);
			gameObject = moveJoystickHierarchy_.gameObject;
			Enable(true);
		}

		public void Clear()
		{
			if (inputManagerNgui_ != null)
			{
				inputManagerNgui_.MoveTouchUpdated -= UpdateJoystick;
			}
		}

		public void Enable(bool enable)
		{
			enabled = enable;
			if (inputManagerNgui_ != null)
			{
				UpdateJoystick();
			}
		}

		public void Subscribe()
		{
			SingletonManager.Get<InputManagerNgui>(out inputManagerNgui_);
			inputManagerNgui_.MoveTouchUpdated += UpdateJoystick;
			UpdateJoystick();
		}

		public void SwitchActive(bool active)
		{
			if (!(moveJoystickHierarchy_ == null))
			{
				GameObjectUtils.SwitchActive(moveJoystickHierarchy_.foundation.gameObject, active);
				GameObjectUtils.SwitchActive(moveJoystickHierarchy_.stick.gameObject, active);
			}
		}

		public void UpdateJoystick()
		{
			if (!enabled)
			{
				SwitchActive(false);
				return;
			}
			SwitchActive(true);
			if (!(moveJoystickHierarchy_.foundation == null) && !(moveJoystickHierarchy_.stick == null))
			{
				if (inputManagerNgui_.MoveTouch != null)
				{
					NguiUtils.SetScreenPosition(moveJoystickHierarchy_.foundation.transform, inputManagerNgui_.MoveTouchStartPosition, uiRoot.UICamera);
					NguiUtils.SetScreenPosition(moveJoystickHierarchy_.stick.transform, inputManagerNgui_.MoveTouch.position, uiRoot.UICamera);
					moveJoystickHierarchy_.stick.transform.localPosition = Vector3Utils.RestrictPos(moveJoystickHierarchy_.foundation.transform.localPosition, moveJoystickHierarchy_.stick.transform.localPosition, 83f);
				}
				else
				{
					moveJoystickHierarchy_.foundation.transform.localPosition = Vector3.zero;
					moveJoystickHierarchy_.stick.transform.localPosition = Vector3.zero;
				}
			}
		}
	}
}
