using UnityEngine;

namespace Modules.PerfomanceTests
{
	public class PerfomanceTestsUtility : PermanentSingleton
	{
		public bool ready;

		public int memorySize;

		public bool supportPerspectiveCameras;

		public PerfomanceTestsUtility()
		{
			ready = false;
		}

		public override void Init()
		{
			DoTests();
		}

		public void DoTests()
		{
			memorySize = SystemInfo.systemMemorySize;
			supportPerspectiveCameras = DevicePerspectiveCameraSupportUtility.FullTest();
			ready = true;
		}
	}
}
