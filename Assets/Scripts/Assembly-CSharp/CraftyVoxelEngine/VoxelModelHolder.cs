using CraftyEngine.Infrastructure.FileSystem;
using CraftyVoxelEngine.Content;

namespace CraftyVoxelEngine
{
	public struct VoxelModelHolder
	{
		public ushort id;

		public VoxelModelsEntries Entry;

		public FileHolder holder;
	}
}
