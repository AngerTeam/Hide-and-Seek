using System;
using System.Collections.Generic;
using CraftyEngine.Utils;

namespace PlayerModule.Playmate
{
	public class PlayerBodyManager : Singleton
	{
		private Dictionary<int, Type> types_;

		public IBodyView GetBodyView(int bodyType)
		{
			return Instatiate(bodyType);
		}

		public override void Init()
		{
			types_ = new Dictionary<int, Type>();
		}

		public IBodyView Instatiate(int bodyType)
		{
			if (bodyType == 0)
			{
				bodyType = BodyType.DEFAULT;
			}
			Type type = types_[bodyType];
			IBodyView bodyView = (IBodyView)Activator.CreateInstance(type);
			bodyView.Type = bodyType;
			bodyView.corpseAnimationRequired = EnumUtils.Contains(256, bodyType);
			bodyView.supportsItem = EnumUtils.Contains(274, bodyType);
			bodyView.supportsSkin = EnumUtils.Contains(258, bodyType);
			return bodyView;
		}

		public override void OnDataLoaded()
		{
			RegisterType<HumanBodyView>(2);
		}

		public void RegisterType<T>(int type) where T : IBodyView, new()
		{
			types_[type] = typeof(T);
		}
	}
}
