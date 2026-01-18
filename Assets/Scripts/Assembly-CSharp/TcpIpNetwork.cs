using System;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using CraftyEngine;
using CraftyEngine.Infrastructure;
using Extensions;
using TcpIpNetworkModule;
using UnityEngine;

public class TcpIpNetwork : IDisposable, INetwork
{
	private class DisposableSocket : Socket
	{
		public DisposableSocket(AddressFamily family, SocketType type, ProtocolType proto)
			: base(family, type, proto)
		{
		}

		public void Clear()
		{
			Dispose(true);
		}
	}

	private class IncomingMessage
	{
		public byte[] data;

		public bool hasLength;

		public int length;

		public int position;
	}

	private class OutgoingMessage
	{
		public bool addSize;

		public byte[] bytes;

		public OutgoingMessage(byte[] bytes, bool addSize)
		{
			this.bytes = bytes;
			this.addSize = addSize;
		}
	}

	public const int MAX_MESSAGE_SIZE = 10485760;

	public bool supressErrors;

	private DisposableSocket client_;

	private SocketError errorCodeRecieve_;

	private SocketError errorCodeSend_;

	private SocketReciever reciever_;

	private IUpdate updater_;

	private bool connectionCompleted_;

	private ThreadDataTransfer<byte[]> recieveQueue_;

	private ThreadDataTransfer<OutgoingMessage> sendQueue_;

	private IncomingMessage currentMessage_;

	private IncomingMessage sizeMessage_;

	private bool disposed_;

	private bool virgin_;

	private bool processInUnity_;

	protected string filePathForSave;

	public string Id { get; set; }

	public bool AllowSending { get; set; }

	public bool Logging { get; set; }

	public event Action<string> Closed;

	public event Action<byte[]> MessageRecieved;

	public event Action Opened;

	public event Action Connecting;

	public TcpIpNetwork(IUpdate updater, bool processInUnity, string id)
	{
		Id = ((!string.IsNullOrEmpty(id)) ? id : GetHashCode().ToString());
		filePathForSave = Application.persistentDataPath;
		processInUnity_ = processInUnity;
		AllowSending = true;
		updater_ = updater;
		virgin_ = true;
		recieveQueue_ = new ThreadDataTransfer<byte[]>(processInUnity);
		recieveQueue_.Process += ReportRecieve;
		updater_.Updated += Update;
		sendQueue_ = new ThreadDataTransfer<OutgoingMessage>(false);
		sendQueue_.Process += ProcessSend;
		sizeMessage_ = new IncomingMessage();
		sizeMessage_.length = 4;
		sizeMessage_.hasLength = true;
		sizeMessage_.data = new byte[4];
		currentMessage_ = new IncomingMessage();
	}

	public override string ToString()
	{
		return string.Format("{1}TcpIpNetwork {0}", Id, (!disposed_) ? string.Empty : "Disposed ");
	}

	public void Close()
	{
		if (client_ != null)
		{
			if (client_.Connected)
			{
				client_.Close();
			}
			client_.Clear();
		}
		client_ = null;
		recieveQueue_.Clear();
		if (this.Closed != null)
		{
			this.Closed("Closed by user");
		}
	}

	public void Connect(string url, int port = 20000)
	{
		this.Connecting.SafeInvoke();
		virgin_ = true;
		sendQueue_.holdProcess = false;
		string text = string.Format("{0}:{1}", url, port);
		Debug.Log("TcpIp connecting to " + text);
		IPAddress[] hostAddresses = Dns.GetHostAddresses(url);
		IPAddress iPAddress = hostAddresses[0];
		client_ = new DisposableSocket(iPAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
		reciever_ = new SocketReciever();
		IPEndPoint point = new IPEndPoint(iPAddress, port);
		Thread thread = new Thread((ThreadStart)delegate
		{
			ConnectAsync(point);
		});
		thread.Start();
	}

	private void ConnectAsync(IPEndPoint point)
	{
		Log.Info("ConnectAsync");
		client_.Connect(point);
		connectionCompleted_ = true;
		BeginReceive();
	}

	public virtual void Dispose()
	{
		if (!disposed_)
		{
			disposed_ = true;
			Close();
			this.Closed = null;
			this.MessageRecieved = null;
			this.Opened = null;
			if (updater_ != null)
			{
				updater_.Updated -= Update;
			}
			sendQueue_.Dispose();
			recieveQueue_.Dispose();
		}
	}

	public bool Send(byte[] bytes, bool addSize)
	{
		if (disposed_ || client_ == null || !client_.Connected || !AllowSending)
		{
			return false;
		}
		sendQueue_.Enqueue(new OutgoingMessage(bytes, addSize));
		return true;
	}

	public bool Send(byte[] bytes)
	{
		return Send(bytes, true);
	}

	private void AddMessageToQueue()
	{
		recieveQueue_.Enqueue(currentMessage_.data);
		currentMessage_.data = null;
	}

	private void BeginReceive()
	{
		if (!disposed_)
		{
			if (Logging)
			{
				Log.Info(Id + " BeginReceive");
			}
			client_.BeginReceive(reciever_.buffer, 0, 2048, SocketFlags.None, out errorCodeRecieve_, HandleReceive, reciever_);
		}
	}

	private void HandleReceive(IAsyncResult result)
	{
		if (disposed_)
		{
			return;
		}
		TryReportError(errorCodeRecieve_);
		try
		{
			SocketReciever socketReciever = (SocketReciever)result.AsyncState;
			socketReciever.length = client_.EndReceive(result, out errorCodeRecieve_);
			TryReportError(errorCodeRecieve_);
			if (Logging)
			{
				string message = Id + " Start received data, size: " + socketReciever.length;
				Log.Info(message);
			}
			TryGetMessages(socketReciever);
		}
		catch (Exception data)
		{
			if (!disposed_)
			{
				Exc.Report(3104, this, data);
			}
		}
		if (!disposed_)
		{
			BeginReceive();
		}
	}

	private void ProcessSend(OutgoingMessage message)
	{
		if (client_ == null || disposed_ || !AllowSending)
		{
			return;
		}
		byte[] bytes = message.bytes;
		if (Logging)
		{
			Debug.LogFormat("Send message {0} bytes long", bytes.Length);
		}
		try
		{
			byte[] length = ByteUtils.GetLength(bytes);
			if (message.addSize)
			{
				client_.Send(length, 0, length.Length, SocketFlags.None, out errorCodeSend_);
				TryReportError(errorCodeSend_);
			}
			client_.Send(bytes, 0, bytes.Length, SocketFlags.None, out errorCodeSend_);
			TryReportError(errorCodeSend_);
			message.bytes = null;
		}
		catch (Exception data)
		{
			Exc.Report(3104, this, data);
		}
	}

	private bool ReadLoop(SocketReciever reciever)
	{
		if (Logging)
		{
			string message = Id + " Reciever state: lenght: " + reciever.length + ", position: " + reciever.position + ". SizeMessage state: position: " + sizeMessage_.position + ". CurrentMessage state: hasLength: " + currentMessage_.hasLength + ", length: " + currentMessage_.length + ", position: " + currentMessage_.position;
			Log.Info(message);
		}
		bool flag;
		if (currentMessage_.hasLength)
		{
			flag = TryReadMessage(currentMessage_, reciever);
			if (flag)
			{
				AddMessageToQueue();
			}
			if (Logging)
			{
				string message2 = Id + " Continue read CurrentMessage: success: " + flag + ", position: " + currentMessage_.position + ", lenght: " + currentMessage_.length + ", reciever state: position: " + reciever.position;
				Log.Info(message2);
			}
		}
		else
		{
			flag = TryReadMessage(sizeMessage_, reciever);
			if (Logging)
			{
				string message3 = Id + " Result read SizeMessage: success: " + flag + ", position: " + sizeMessage_.position + ", reciever state: position: " + reciever.position;
				Log.Info(message3);
			}
			if (flag)
			{
				sizeMessage_.position = 0;
				currentMessage_.length = ByteUtils.ReadLength(sizeMessage_.data);
				if (currentMessage_.length > 10485760)
				{
					string data = string.Format("{0} Message size {1} exceeds maximum size!", Id, currentMessage_.length);
					Exc.Report(3105, this, data);
					if (Logging)
					{
						data = Id + " Error read CurrentMessage: " + ", position: " + currentMessage_.position + ", lenght: " + currentMessage_.length + ", reciever state: position: " + reciever.position;
						Log.Error(data);
					}
					return false;
				}
				currentMessage_.hasLength = true;
				currentMessage_.data = new byte[currentMessage_.length];
				flag = TryReadMessage(currentMessage_, reciever);
				if (flag)
				{
					AddMessageToQueue();
				}
				if (Logging)
				{
					string message4 = Id + "Result read CurrentMessage: success: " + flag + ", position: " + currentMessage_.position + ", lenght: " + currentMessage_.length + ", reciever state: position: " + reciever.position;
					Log.Info(message4);
				}
			}
		}
		return flag;
	}

	private void ReportRecieve(byte[] message)
	{
		if (this.MessageRecieved != null)
		{
			this.MessageRecieved(message);
		}
	}

	private void TryGetMessages(SocketReciever reciever)
	{
		reciever.position = 0;
		if (reciever.length <= 0)
		{
			return;
		}
		int num = 0;
		bool flag;
		do
		{
			try
			{
				flag = ReadLoop(reciever);
			}
			catch (Exception data)
			{
				Exc.Report(3104, this, data);
				break;
			}
			num++;
			if (num == 256)
			{
				throw new StackOverflowException();
			}
		}
		while (flag);
	}

	private bool TryReadMessage(IncomingMessage message, SocketReciever reciever)
	{
		int num = reciever.length - reciever.position;
		if (num <= 0)
		{
			return false;
		}
		int val = message.length - message.position;
		int num2 = Math.Min(val, num);
		Array.Copy(reciever.buffer, reciever.position, message.data, message.position, num2);
		reciever.position += num2;
		message.position += num2;
		if (message.position == message.length)
		{
			message.hasLength = false;
			message.position = 0;
			return true;
		}
		return false;
	}

	private void TryReportConnected()
	{
		if (!disposed_ && client_ != null && connectionCompleted_ && client_.Connected && virgin_)
		{
			virgin_ = false;
			if (this.Opened != null)
			{
				this.Opened();
			}
		}
	}

	private void TryReportError(SocketError status)
	{
		if (status != 0)
		{
			Exc.Report(3106, this, status);
		}
	}

	private void Update()
	{
		if (!disposed_)
		{
			if (processInUnity_)
			{
				recieveQueue_.Update();
			}
			TryReportConnected();
			if (!virgin_ && client_ != null && !client_.Connected)
			{
				virgin_ = true;
				Dispose();
			}
		}
	}
}
