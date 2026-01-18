using System;
using System.Collections.Generic;

namespace HudSystem
{
	public class GuiModuleHolder : Singleton
	{
		private static Dictionary<Type, GuiModlule> modules_;

		public override void Init()
		{
			if (modules_ == null)
			{
				modules_ = new Dictionary<Type, GuiModlule>();
			}
		}

		public override void OnLogicLoaded()
		{
			foreach (GuiModlule value in modules_.Values)
			{
				value.Resubscribe();
			}
		}

		public override void Dispose()
		{
			foreach (GuiModlule value in modules_.Values)
			{
				value.Dispose();
			}
			modules_.Clear();
		}

		public static T Add<T>(T module) where T : GuiModlule
		{
			modules_.Add(typeof(T), module);
			module.Resubscribe();
			return module;
		}

		public static void Remove(GuiModlule module)
		{
			module.Dispose();
			Type type = module.GetType();
			modules_.Remove(type);
		}

		public static void Remove<T>() where T : GuiModlule
		{
			T module;
			if (TryGet<T>(out module))
			{
				Remove(module);
			}
		}

		public static T Add<T>() where T : GuiModlule, new()
		{
			try
			{
				return Add(new T());
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
			}
			return (T)null;
		}

		public static T GetOrAdd<T>() where T : GuiModlule, new()
		{
			try
			{
				if (Contains<T>())
				{
					return Get<T>();
				}
				return Add(new T());
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
			}
			return (T)null;
		}

		public static TName AddAlias<TName, TAlias>() where TName : GuiModlule, TAlias, new() where TAlias : class
		{
			TName val = new TName();
			modules_.Add(typeof(TAlias), val);
			val.Resubscribe();
			return val;
		}

		public static bool TryGet<T>(out T module) where T : class
		{
			Type typeFromHandle = typeof(T);
			if (modules_.ContainsKey(typeFromHandle))
			{
				module = modules_[typeFromHandle] as T;
				return module != null;
			}
			module = (T)null;
			return false;
		}

		public static void Get<T>(out T module) where T : class
		{
			module = modules_[typeof(T)] as T;
		}

		public static T Get<T>() where T : class
		{
			return modules_[typeof(T)] as T;
		}

		public static bool Contains<T>()
		{
			Type typeFromHandle = typeof(T);
			return modules_.ContainsKey(typeFromHandle);
		}
	}
}
