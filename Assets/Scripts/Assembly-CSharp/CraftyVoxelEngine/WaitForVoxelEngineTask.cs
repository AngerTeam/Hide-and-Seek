using System;
using CraftyEngine.Infrastructure;
using DG.Tweening;
using Extensions;

namespace CraftyVoxelEngine
{
	public class WaitForVoxelEngineTask : ProgressableTask
	{
		private Tweener tweener_;

		private VoxelEngine voxelEngine_;

		public float duration;

		public event Action Started;

		public WaitForVoxelEngineTask()
		{
			duration = 10f;
		}

		public override void Start()
		{
			this.Started.SafeInvoke();
			tweener_ = DOTween.To(() => 0f, base.ReportProgress, 1f, duration).SetEase(Ease.OutQuad).OnComplete(OutOfTime);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			voxelEngine_.voxelEvents.OutOfRenderingTasks += OutOfTasks;
			voxelEngine_.ViewManager.OutOfMeshs += OutOfTasks;
		}

		private void Close()
		{
			voxelEngine_.voxelEvents.OutOfRenderingTasks -= OutOfTasks;
			voxelEngine_.ViewManager.OutOfMeshs -= OutOfTasks;
			if (tweener_ != null)
			{
				tweener_.Kill();
			}
			Complete();
		}

		private bool IsSomethingRendered()
		{
			int num = 0;
			Array3D<ChunkView> chunkViews = voxelEngine_.ViewManager.chunkViews;
			for (int i = 0; i < chunkViews.Length; i++)
			{
				ChunkView chunkView = chunkViews[i];
				if (chunkView != null && chunkView.Views.Count > 0)
				{
					num++;
				}
			}
			return num > 0;
		}

		private void OutOfTasks(MessageOutOfRenderingTasks message)
		{
			Close();
		}

		private void OutOfTasks()
		{
			Close();
		}

		private void OutOfTime()
		{
			if (IsSomethingRendered())
			{
				Log.Warning("Wait Voxel: engine rendered chunls for {0} seconds!", duration);
				Close();
			}
			else
			{
				Log.Error("Wait Voxel: engine didn't render any chunks for {0} seconds", duration);
				Close();
			}
		}
	}
}
