using System;

public interface INetwork : IDisposable
{
	bool AllowSending { get; set; }

	bool Logging { get; set; }

	event Action Opened;

	event Action<byte[]> MessageRecieved;

	event Action<string> Closed;

	void Connect(string url, int port);

	bool Send(byte[] command);

	bool Send(byte[] command, bool addSize);
}
