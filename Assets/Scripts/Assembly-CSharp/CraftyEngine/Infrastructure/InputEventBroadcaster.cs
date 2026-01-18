using System;

namespace CraftyEngine.Infrastructure
{
	public class InputEventBroadcaster : Singleton
	{
		protected InputModel model;

		public InputModel Model
		{
			get
			{
				return model;
			}
		}

		public override void Init()
		{
			GetSingleton<InputModel>(out model);
		}

		protected void Try(EventHandler<InputEventArgs> eventHandler, InputInstance instance = null)
		{
			Try(eventHandler, new InputEventArgs
			{
				touch = instance
			});
		}

		protected void Try(EventHandler<InputEventArgs> eventHandler, InputEventArgs args)
		{
			try
			{
				if (args.touch == null)
				{
					args.touch = model.CurrentInstance;
				}
				if (eventHandler != null)
				{
					eventHandler(this, args);
				}
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
			}
		}
	}
}
