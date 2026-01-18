using System;
using System.Collections.Generic;

namespace CraftyVoxelEngine
{
	public class VoxelEvents : VoxelEventsBase
	{
		public event Action<MessageChunkChanged> ChunkChanged;

		public event Action<MessageEndOfThread> EndOfThread;

		public event Action<MessageFileDataReady> FileDataReady;

		public event Action<MessageInteractiveVoxelChanged> InteractiveVoxelChanged;

		public event Action<MessageKeyOutOfMap> KeyOutOfMap;

		public event Action<MessageOutOfRenderingTasks> OutOfRenderingTasks;

		public event Action<MessageOutOfTasks> OutOfTasks;

		public event Action<MessageUnknownMessage> Unknown;

		public event Action<MessageVoxelChanged> VoxelChanged;

		public event Action<MessageVoxelDataReady> VoxelDataReady;

		public event Action<MessageVoxelRendered> VoxelRendered;

		public event Action<MessageMapSaved> MapSaved;

		public event Action<MessageLogicVoxelChanged> LogicVoxelChanged;

		public VoxelEvents(VoxelCore voxelCore, Dictionary<int, Action<DataSerializable>> handlers)
			: base(voxelCore, handlers)
		{
		}

		public void Update()
		{
			VoxelEventsBase.buffer_.Reset();
			Message message = new Message();
			while (core_.ReceiveMessage(VoxelEventsBase.buffer_))
			{
				VoxelEventsBase.buffer_.Reset();
				message.Deserialize(VoxelEventsBase.buffer_);
				VoxelEventsBase.buffer_.Reset();
				Action<DataSerializable> value = null;
				handlers.TryGetValue(message.MESSAGE_SEQ, out value);
				switch (message.MESSAGE_ID)
				{
				case 5001:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.Unknown);
					break;
				case 5007:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.VoxelRendered);
					break;
				case 5009:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.VoxelDataReady);
					break;
				case 5010:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.FileDataReady);
					break;
				case 5011:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.VoxelChanged);
					break;
				case 5012:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.InteractiveVoxelChanged);
					break;
				case 5013:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.KeyOutOfMap);
					break;
				case 5014:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.ChunkChanged);
					break;
				case 5015:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.OutOfTasks);
					break;
				case 5016:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.OutOfRenderingTasks);
					break;
				case 5017:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.EndOfThread);
					break;
				case 5021:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.MapSaved);
					break;
				case 5022:
					VoxelEventsBase.HandleMessage(VoxelEventsBase.buffer_, value, this.LogicVoxelChanged);
					break;
				default:
					Log.Temp("Unknown message " + message.MESSAGE_ID);
					break;
				}
			}
		}
	}
}
