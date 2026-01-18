using System;
using CraftyEngine.Infrastructure;
using InventoryModule;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerHandController : IDisposable
	{
		public MyPlayerHandItemSwitcher Switcher { get; private set; }

		public MyPlayerHandShaker Shaker { get; private set; }

		public MyPlayerHandController()
		{
			CameraManager cameraManager = SingletonManager.Get<CameraManager>();
			Transform transform = cameraManager.Transform;
			GameObject gameObject = new GameObject("MyPlayerHandShaker");
			gameObject.transform.SetParent(transform, false);
			GameObject gameObject2 = new GameObject("MyPlayerItemSwitcher");
			gameObject2.transform.SetParent(gameObject.transform, false);
			GameObject gameObject3 = new GameObject("MyPlayerItemContainer");
			gameObject3.transform.SetParent(gameObject2.transform, false);
			gameObject2.transform.localPosition = new Vector3(0.8f, -0.9f, 1.2f);
			gameObject2.transform.localEulerAngles = new Vector3(0f, 90f, 0f);
			Shaker = new MyPlayerHandShaker(gameObject);
			Switcher = new MyPlayerHandItemSwitcher(gameObject2, gameObject3);
		}

		public void Dispose()
		{
			Switcher.Dispose();
			Shaker.Dispose();
		}

		public void UpdateHandItem(int articulId)
		{
			if (articulId == 0)
			{
				articulId = InventoryContentMap.CraftSettings.handArtikulId;
			}
			Switcher.SwitchItem(articulId);
		}

		internal Quaternion GetHandledRotation()
		{
			return Quaternion.identity;
		}
	}
}
