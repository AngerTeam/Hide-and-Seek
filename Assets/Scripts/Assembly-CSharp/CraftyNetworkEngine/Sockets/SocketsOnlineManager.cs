using System;
using System.Collections.Generic;
using CraftyEngine;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using Extensions;
using Interlace.Amf;
using Interlace.Amf.Extended;
using RemoteData;
using TcpIpNetworkModule;

namespace CraftyNetworkEngine.Sockets
{
	public class SocketsOnlineManager : Singleton
	{
		private const int OK_SOCKETS_SERVER_STATUS = 0;

		private Queue<Message> commandsQueue_;

		private Dictionary<int, RemoteCommand> commandsWithResponses_;

		private int seq_;

		private Updater updater_;

		private bool disposed_;

		public WithHttpHeader Network { get; private set; }

		public event Action<string, AmfObject> CommandRecieved;

		public event Action Connected;

		public event Action SocketsClosed;

		public void Connect(string url, int port)
		{
			updater_ = new Updater();
			Network = new WithHttpHeader(updater_, "pvp", true);
			Network.AllowSending = true;
			Network.AmfMessageRecieved += HandleMessageRecieved;
			Network.Opened += ReportConnected;
			Network.Closed += ReportClosed;
			Network.Connect(url, port);
		}

		public void Disconnect()
		{
			if (commandsWithResponses_ != null)
			{
				foreach (RemoteCommand value in commandsWithResponses_.Values)
				{
					value.ResponceNotRecieved -= HandleResponceNotRecieved;
					value.StopTimer();
				}
				commandsWithResponses_.Clear();
			}
			if (Network != null)
			{
				Network.AmfMessageRecieved -= HandleMessageRecieved;
				Network.Opened -= ReportConnected;
				Network.Closed -= ReportClosed;
				Network.Dispose();
				Network = null;
			}
		}

		public override void Dispose()
		{
			if (!disposed_)
			{
				disposed_ = true;
				Disconnect();
			}
		}

		public override void Init()
		{
			commandsQueue_ = new Queue<Message>();
			commandsWithResponses_ = new Dictionary<int, RemoteCommand>();
		}

		public void Send(byte[] data, bool addSize)
		{
			if (!disposed_ && Network != null)
			{
				Network.Send(data, addSize);
			}
		}

		public void Send(AmfObject obj)
		{
			if (!disposed_ && Network != null)
			{
				Network.Send(AmfHelper.Write(obj));
			}
		}

		public void Send(RemoteCommand command)
		{
			AmfObject amfObject = command.Serialize();
			command.seq = SetSeq(amfObject);
			if (command.ResponseNeeded)
			{
				command.StartTimer();
				command.ResponceNotRecieved += HandleResponceNotRecieved;
				commandsWithResponses_.Add(command.seq, command);
			}
			Send(amfObject);
			command.ReleaseAmf(amfObject);
		}

		public int SetSeq(AmfObject obj)
		{
			int num = seq_;
			obj.Properties["seq"] = num;
			seq_++;
			return num;
		}

		private void AddCommand(string cmd, int seq, AmfObject obj, int status = -1)
		{
			commandsQueue_.Enqueue(new Message
			{
				name = cmd,
				seq = seq,
				obj = obj,
				status = status
			});
		}

		private void HandleMessageRecieved(AmfObject amf)
		{
			ParseMessage(amf);
			Publish();
		}

		private void HandleMessageRecieved(byte[] data)
		{
			ParseMessage(data);
			Publish();
		}

		private void HandleResponceNotRecieved(RemoteCommand command)
		{
			if (!disposed_)
			{
				commandsWithResponses_.Remove(command.seq);
				command.ResponceNotRecieved -= HandleResponceNotRecieved;
			}
		}

		private void HandleResponceRecieved(int seq, AmfObject amfObject)
		{
			RemoteCommand value;
			if (commandsWithResponses_.TryGetValue(seq, out value))
			{
				value.ReportResponceRecieved(amfObject);
				value.Clear();
				commandsWithResponses_.Remove(seq);
			}
		}

		private void ParseMessage(byte[] rawData)
		{
			AmfObject obj;
			try
			{
				obj = AmfHelper.ReadObject(rawData);
			}
			catch (Exception data)
			{
				Exc.Report(3102, Network, data);
				return;
			}
			ParseMessage(obj);
		}

		private void ParseMessage(AmfObject obj)
		{
			object value;
			object value5;
			if (obj.Properties.TryGetValue("resp", out value))
			{
				string cmd = (string)value;
				int seq = (int)obj.Properties["seq"];
				int num = -1;
				object value2;
				if (obj.Properties.TryGetValue("status", out value2))
				{
					num = (int)value2;
				}
				string value3 = null;
				object value4;
				if (obj.Properties.TryGetValue("error", out value4))
				{
					value3 = (string)value4;
				}
				if (num != 0 || !string.IsNullOrEmpty(value3))
				{
					Exc.Report(num, Network, obj);
				}
				AddCommand(cmd, seq, obj, num);
			}
			else if (obj.Properties.TryGetValue("cmd", out value5))
			{
				AddCommand((string)value5, -1, obj);
			}
			else
			{
				Exc.Report(3101, Network, AmfHelper.AmfToString(obj));
			}
		}

		private void Publish()
		{
			while (commandsQueue_.Count > 0)
			{
				Message message = commandsQueue_.Dequeue();
				if (message.seq == -1)
				{
					if (this.CommandRecieved != null)
					{
						this.CommandRecieved(message.name, message.obj);
					}
				}
				else if (message.status == 0)
				{
					HandleResponceRecieved(message.seq, message.obj);
				}
				OptAmfObject optAmfObject = message.obj as OptAmfObject;
				if (optAmfObject != null)
				{
					optAmfObject.Dispose();
				}
			}
		}

		private void ReportClosed(string message)
		{
			if (commandsWithResponses_.Count > 0)
			{
				Log.Warning("Still have {0} responces {1}", commandsWithResponses_.Count, ArrayUtils.DictionaryToString(commandsWithResponses_));
			}
			this.SocketsClosed.SafeInvoke();
		}

		private void ReportConnected()
		{
			this.Connected.SafeInvoke();
		}
	}
}
