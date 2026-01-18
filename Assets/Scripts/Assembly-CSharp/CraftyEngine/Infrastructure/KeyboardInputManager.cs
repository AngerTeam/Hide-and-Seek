using System;
using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class KeyboardInputManager : InputEventBroadcaster
	{
		private KeyCode[] buttonAlphaCodes_;

		private KeyCode[] buttonCodes_;

		private Dictionary<KeyCode, Action> hotKeys_;

		private KeyCode[] letterCodes_;

		private UnityEvent unityEvent_;

		public event EventHandler<InputEventArgs> ButtonAlphaPressed;

		public event EventHandler<InputEventArgs> ButtonAlphaReleased;

		public event EventHandler<InputEventArgs> ButtonPressed;

		public event EventHandler<InputEventArgs> ButtonReleased;

		public KeyboardInputManager()
		{
			hotKeys_ = new Dictionary<KeyCode, Action>();
		}

		public void AddHotkey(KeyCode hotKey, Action action)
		{
			if (!CompileConstants.MOBILE || CompileConstants.EDITOR)
			{
				hotKeys_[hotKey] = action;
			}
		}

		public override void Dispose()
		{
			buttonAlphaCodes_ = null;
			buttonCodes_ = null;
			letterCodes_ = null;
			hotKeys_ = null;
			unityEvent_.Unsubscribe(UnityEventType.Update, HandleKeyboard);
		}

		public override void Init()
		{
			base.Init();
			buttonCodes_ = new KeyCode[20]
			{
				KeyCode.F1,
				KeyCode.F2,
				KeyCode.F3,
				KeyCode.F4,
				KeyCode.F5,
				KeyCode.F6,
				KeyCode.F7,
				KeyCode.F8,
				KeyCode.F9,
				KeyCode.F10,
				KeyCode.F11,
				KeyCode.F12,
				KeyCode.Insert,
				KeyCode.Home,
				KeyCode.PageUp,
				KeyCode.Delete,
				KeyCode.End,
				KeyCode.PageDown,
				KeyCode.Escape,
				KeyCode.Tab
			};
			letterCodes_ = new KeyCode[25]
			{
				KeyCode.Space,
				KeyCode.Q,
				KeyCode.E,
				KeyCode.R,
				KeyCode.T,
				KeyCode.Y,
				KeyCode.U,
				KeyCode.I,
				KeyCode.O,
				KeyCode.P,
				KeyCode.F,
				KeyCode.G,
				KeyCode.H,
				KeyCode.J,
				KeyCode.K,
				KeyCode.L,
				KeyCode.Z,
				KeyCode.X,
				KeyCode.C,
				KeyCode.V,
				KeyCode.B,
				KeyCode.N,
				KeyCode.M,
				KeyCode.LeftAlt,
				KeyCode.RightAlt
			};
			buttonAlphaCodes_ = new KeyCode[12]
			{
				KeyCode.Alpha1,
				KeyCode.Alpha2,
				KeyCode.Alpha3,
				KeyCode.Alpha4,
				KeyCode.Alpha5,
				KeyCode.Alpha6,
				KeyCode.Alpha7,
				KeyCode.Alpha8,
				KeyCode.Alpha9,
				KeyCode.Alpha0,
				KeyCode.Minus,
				KeyCode.Equals
			};
			GetSingleton<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, HandleKeyboard);
		}

		public void PressMobileJump()
		{
			Try(this.ButtonPressed, new InputEventArgs
			{
				keyCode = KeyCode.Space
			});
		}

		public void ReleaseMobileJump()
		{
			Try(this.ButtonReleased, new InputEventArgs
			{
				keyCode = KeyCode.Space
			});
		}

		private void HandleKeyboard()
		{
			PressedKey.Shift = Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift);
			PressedKey.Space = Input.GetKey(KeyCode.Space);
			PressedKey.Ctrl = Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl);
			PressedKey.Alt = Input.GetKey(KeyCode.LeftAlt) || Input.GetKey(KeyCode.RightAlt);
			model.Shift = PressedKey.Shift;
			model.Space = PressedKey.Space;
			model.Alt = PressedKey.Alt;
			for (int i = 0; i < buttonCodes_.Length; i++)
			{
				KeyCode keyCode = buttonCodes_[i];
				if (Input.GetKeyUp(keyCode))
				{
					HotkeyPressed(keyCode);
					Try(this.ButtonReleased, new InputEventArgs
					{
						keyCode = keyCode
					});
				}
				if (Input.GetKeyDown(keyCode))
				{
					Try(this.ButtonPressed, new InputEventArgs
					{
						keyCode = keyCode
					});
				}
			}
			if (model.allowHotkeyProcess)
			{
				for (int j = 0; j < letterCodes_.Length; j++)
				{
					KeyCode keyCode2 = letterCodes_[j];
					if (Input.GetKeyUp(keyCode2))
					{
						HotkeyPressed(keyCode2);
						Try(this.ButtonReleased, new InputEventArgs
						{
							keyCode = keyCode2
						});
					}
					if (Input.GetKeyDown(keyCode2))
					{
						Try(this.ButtonPressed, new InputEventArgs
						{
							keyCode = keyCode2
						});
					}
				}
				PressedKey.Alpha = null;
				for (int k = 0; k < buttonAlphaCodes_.Length; k++)
				{
					int value = k;
					KeyCode keyCode3 = buttonAlphaCodes_[k];
					if (Input.GetKeyUp(keyCode3))
					{
						Try(this.ButtonAlphaReleased, new InputEventArgs
						{
							keyCode = keyCode3,
							alpha = value
						});
					}
					if (Input.GetKeyDown(keyCode3))
					{
						Try(this.ButtonAlphaPressed, new InputEventArgs
						{
							keyCode = keyCode3,
							alpha = value
						});
					}
					if (Input.GetKey(keyCode3))
					{
						PressedKey.Alpha = value;
					}
				}
			}
			if (Input.GetKeyUp(KeyCode.KeypadEnter) || Input.GetKeyUp(KeyCode.Return))
			{
				Try(this.ButtonReleased, new InputEventArgs
				{
					keyCode = KeyCode.Return
				});
			}
		}

		private void HotkeyPressed(KeyCode keyCode)
		{
			foreach (KeyValuePair<KeyCode, Action> item in hotKeys_)
			{
				if (item.Key == keyCode)
				{
					item.Value();
					break;
				}
			}
		}
	}
}
