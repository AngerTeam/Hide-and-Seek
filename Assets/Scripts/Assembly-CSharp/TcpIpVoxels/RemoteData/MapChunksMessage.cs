using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class MapChunksMessage : RemoteMessage
	{
		public int packet;

		public ChunkDiffMessage[] chunks;

		public MapChunksMessage(int packet, ChunkDiffMessage[] chunks)
		{
			this.packet = packet;
			this.chunks = chunks;
		}

		public MapChunksMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			packet = Get<int>(source, "packet", false);
			chunks = GetArray<ChunkDiffMessage>(source, "chunks");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("MapChunksMessage: packet: {0};\n chunks: {1}", packet, ArrayUtils.ArrayToString(chunks, "\n\t"));
		}
	}
}
