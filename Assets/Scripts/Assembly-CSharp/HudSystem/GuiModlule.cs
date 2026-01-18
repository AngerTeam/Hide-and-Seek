using System;

namespace HudSystem
{
	public abstract class GuiModlule : IDisposable
	{
		public abstract void Dispose();

		public virtual void Resubscribe()
		{
		}
	}
}
