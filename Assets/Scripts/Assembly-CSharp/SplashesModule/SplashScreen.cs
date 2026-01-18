using System;
using UnityEngine;

namespace SplashesModule
{
	public class SplashScreen : IDisposable
	{
		public int id;

		public string prefab;

		public GameObject gameObject;

		public SplashScreenHierarchy heirarchy;

		public UIProgressBar slider;

		public UiRoller roller;

		public void Dispose()
		{
			roller.Dispose();
		}
	}
}
