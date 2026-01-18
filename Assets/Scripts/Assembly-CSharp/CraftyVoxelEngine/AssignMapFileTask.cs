using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;

namespace CraftyVoxelEngine
{
	public class AssignMapFileTask : AsynchronousTask
	{
		private VoxelEngine engine_;

		private FileHolder mapDataFile_;

		public AssignMapFileTask(FileHolder mapDataFile)
		{
			mapDataFile_ = mapDataFile;
			SingletonManager.Get<VoxelEngine>(out engine_);
		}

		public override void Start()
		{
			engine_.voxelEvents.FileDataReady += HandleFileDataReady;
			engine_.core.SetMapData(mapDataFile_.loadedBytes);
			engine_.Manager.lockRaycast = false;
		}

		private void HandleFileDataReady(MessageFileDataReady obj)
		{
			Complete();
		}
	}
}
