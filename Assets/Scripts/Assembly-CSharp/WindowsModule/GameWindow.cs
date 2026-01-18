using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils.Unity;
using DG.Tweening;
using HudSystem;
using NguiTools;
using UnityEngine;

namespace WindowsModule
{
	public class GameWindow : GuiModlule
	{
		public int minimumDepth;

		public Tween tween;

		public bool Visible;

		public bool closable;

		protected NguiManager nguiManager;

		protected WindowsManager windowsManager;

		protected PrefabsManagerNGUI prefabsManager;

		public GameObject Conteiner { get; private set; }

		public bool DontCloseOnEsc { get; protected set; }

		public int ExclusiveGroup { get; protected set; }

		public bool HeavyGraphics { get; protected set; }

		public BasicWindowHierarchy Hierarchy { get; private set; }

		public GameWindowMemento Initial { get; private set; }

		public bool IsFront { get; private set; }

		public UIWidget[] Widgets { get; private set; }

		public int HudState { get; set; }

		public event EventHandler<BoolEventArguments> IsFrontChanged;

		public event EventHandler<BoolEventArguments> ViewChanged;

		public GameWindow(bool useBackground = true, bool useCloseButton = true)
		{
			closable = true;
			SingletonManager.Get<WindowsManager>(out windowsManager);
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager);
			SingletonManager.Get<NguiManager>(out nguiManager);
			prefabsManager.Load("WindowsModule");
			Hierarchy = prefabsManager.InstantiateNGUIIn<BasicWindowHierarchy>("UIWindow", windowsManager.conteiner);
			Hierarchy.gameObject.name = GetType().Name;
			Hierarchy.envelopContent.enabled = false;
			GameObjectUtils.SwitchActive(Hierarchy.additionalBackbround.gameObject, false);
			if (!useBackground)
			{
				UnityEngine.Object.Destroy(Hierarchy.backbround.gameObject);
			}
			if (!useCloseButton)
			{
				DontCloseOnEsc = true;
				UnityEngine.Object.Destroy(Hierarchy.closeButton.gameObject);
			}
			else
			{
				Hierarchy.closeLabel.text = Localisations.Get("UI_Close");
				Hierarchy.closeButtonWidget.SetAnchor(nguiManager.UiRoot.closeButtonContainer.gameObject);
			}
			Widgets = Hierarchy.GetComponentsInChildren<UIWidget>();
			Conteiner = Hierarchy.gameObject;
			Conteiner.SetActive(false);
			Initial = new GameWindowMemento();
			Initial.Read(this);
			windowsManager.RegisterWindow(this);
			Visible = false;
		}

		public virtual void Clear()
		{
		}

		public override void Dispose()
		{
			Clear();
			Destroy();
		}

		public void ReportIsFrontChanged()
		{
			if (this.IsFrontChanged != null)
			{
				this.IsFrontChanged(this, new BoolEventArguments(IsFront));
			}
		}

		public void ReportIsFrontChanged(bool isFront)
		{
			IsFront = isFront;
			if (this.IsFrontChanged != null)
			{
				this.IsFrontChanged(this, new BoolEventArguments(IsFront));
			}
		}

		public void ReportViewChanged()
		{
			if (this.ViewChanged != null)
			{
				this.ViewChanged(this, new BoolEventArguments(Visible));
			}
		}

		public static void SetParent(Transform content, Transform parent)
		{
			content.SetParent(parent, false);
			content.localPosition = Vector3.zero;
		}

		protected void SetContent(Transform content, bool envelope = true, bool reparent = true, bool offsetTop = false, bool additionalBackground = false, bool permanent = false)
		{
			if (reparent)
			{
				SetParent(content, Conteiner.transform);
			}
			if (envelope)
			{
				if (offsetTop)
				{
					Hierarchy.envelopContent.padTop = 110;
				}
				if (Hierarchy.envelopContent.targetRoot == null)
				{
					UnityEvent unityEvent = SingletonManager.Get<UnityEvent>(permanent ? 1 : 2);
					unityEvent.Subscribe(UnityEventType.Update, Hierarchy.envelopContent.Execute);
				}
				Hierarchy.envelopContent.enabled = true;
				Hierarchy.envelopContent.targetRoot = content;
			}
			if (additionalBackground)
			{
				GameObjectUtils.SwitchActive(Hierarchy.additionalBackbround.gameObject, true);
			}
		}

		private void Destroy()
		{
			windowsManager.UnregisterWindow(this);
			UnityEngine.Object.Destroy(Hierarchy.gameObject);
		}
	}
}
