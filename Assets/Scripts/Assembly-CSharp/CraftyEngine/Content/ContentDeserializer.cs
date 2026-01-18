using System;

namespace CraftyEngine.Content
{
	public sealed class ContentDeserializer
	{
		public static void Deserialize<T>() where T : ContentMapBase, new()
		{
			ContentLoaderModel singlton;
			SingletonManager.Get<ContentLoaderModel>(out singlton, 1);
			T val = new T();
			val.SetValues(singlton.associativeElements);
		}

		public static void Deserialize(Type t)
		{
			ContentLoaderModel singlton;
			SingletonManager.Get<ContentLoaderModel>(out singlton, 1);
			object obj = Activator.CreateInstance(t);
			ContentMapBase contentMapBase = (ContentMapBase)obj;
			contentMapBase.SetValues(singlton.associativeElements);
		}
	}
}
