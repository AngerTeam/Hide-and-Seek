using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class PermanentUnityObjects : Singleton
	{
		private List<Object> objects;

		public override void Init()
		{
			objects = new List<Object>();
		}

		public void Add(Object obj)
		{
			Object.DontDestroyOnLoad(obj);
			objects.Add(obj);
		}

		public override void Dispose()
		{
			foreach (Object @object in objects)
			{
				if (@object != null)
				{
					Object.Destroy(@object);
				}
			}
			objects.Clear();
			objects = null;
		}
	}
}
