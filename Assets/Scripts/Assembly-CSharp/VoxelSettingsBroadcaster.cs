using CraftyVoxelEngine;
using CraftyVoxelEngine.Content;
using Modules.PerfomanceTests;
using UnityEngine;

public class VoxelSettingsBroadcaster : Singleton
{
	private VoxelEngine voxelEngine_;

	public float rendRange = 110f;

	public float viewRange = 80f;

	public override void OnDataLoaded()
	{
		CalculateInterval();
		SingletonManager.Get<VoxelEngine>(out voxelEngine_);
		voxelEngine_.voxelActions.SetViewDistance(rendRange, viewRange, null);
		voxelEngine_.ViewManager.rendRange = rendRange;
		voxelEngine_.ViewManager.viewRange = viewRange;
	}

	public void CalculateInterval()
	{
		PerfomanceTestsUtility singleton;
		if (SingletonManager.TryGet<PerfomanceTestsUtility>(out singleton))
		{
			float memoryRangeMin = VoxelContentMap.VoxelSettings.memoryRangeMin;
			float memoryRangeMax = VoxelContentMap.VoxelSettings.memoryRangeMax;
			float viewRangeMin = VoxelContentMap.VoxelSettings.viewRangeMin;
			float viewRangeMax = VoxelContentMap.VoxelSettings.viewRangeMax;
			float val = FromRange(singleton.memorySize, memoryRangeMin, memoryRangeMax);
			rendRange = ToRange(val, viewRangeMin, viewRangeMax);
			viewRange = ToRange(val, viewRangeMin - 20f, viewRangeMax - 20f);
		}
	}

	private float FromRange(float val, float min, float max)
	{
		return Mathf.Clamp01((val - min) / max);
	}

	private float ToRange(float val, float min, float max)
	{
		return val * (max - min) + min;
	}

	public override void Dispose()
	{
	}
}
