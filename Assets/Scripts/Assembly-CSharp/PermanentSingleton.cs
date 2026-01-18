using System;

public abstract class PermanentSingleton : Singleton
{
	[Obsolete]
	public virtual bool AllowReinitialization { get; set; }
}
