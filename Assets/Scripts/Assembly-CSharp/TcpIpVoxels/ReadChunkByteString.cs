using System.Collections.Generic;
using System.IO;
using Interlace.Amf.Extended;

namespace TcpIpVoxels
{
	public class ReadChunkByteString
	{
		public static Dictionary<int, VoxelValueRotation> valuesCache = new Dictionary<int, VoxelValueRotation>();

		public static void ReadValues(string byteString)
		{
			byte[] data = OptAmfVoxelDiffs.GetData(byteString);
			BinaryReader binaryReader = new BinaryReader(new MemoryStream(data));
			for (int i = 0; i < data.Length; i += 5)
			{
				binaryReader.ReadByte();
				ushort num = binaryReader.ReadUInt16();
				VoxelValueRotation orSet = valuesCache.GetOrSet(num);
				orSet.value = binaryReader.ReadUInt16();
				orSet.index3D = num;
			}
		}

		public static void ReadRotation(string byteString)
		{
			byte[] data = OptAmfVoxelDiffs.GetData(byteString);
			BinaryReader binaryReader = new BinaryReader(new MemoryStream(data));
			for (int i = 0; i < data.Length; i += 4)
			{
				binaryReader.ReadByte();
				ushort num = binaryReader.ReadUInt16();
				VoxelValueRotation orSet = valuesCache.GetOrSet(num);
				orSet.rotation = binaryReader.ReadByte();
				orSet.index3D = num;
			}
		}
	}
}
