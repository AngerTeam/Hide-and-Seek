using System;
using RemoteData;

public class RemoteMessageEventArgs : EventArgs
{
	public int status;

	public string error;

	public RemoteMessage remoteMessage;

	public RemoteMessageEventArgs(RemoteMessage remoteMessage)
	{
		this.remoteMessage = remoteMessage;
	}
}
