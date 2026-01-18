using System;
using Extensions;
using UnityEngine;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelEditorModel : Singleton
	{
		public float autosaveDelay = 180f;

		public string mapPath;

		public bool developer = true;

		public int modeId;

		public bool ValidSpawns;

		public bool playerPosValid;

		public Vector3 playerPosition;

		public Vector3 playerRotation;

		private string savedMap_;

		public bool useCache;

		public string SavedMap
		{
			get
			{
				return savedMap_;
			}
			set
			{
				savedMap_ = value;
				if (!developer)
				{
					this.MapSaved.SafeInvoke(savedMap_);
				}
			}
		}

		public event Action<string> MapSaved;

		public event Action FrameModeToggled;

		public event Action SwitchSlotSelected;

		public void ToggleFrameMode()
		{
			this.FrameModeToggled.SafeInvoke();
		}

		public void SelectSwitchSlot()
		{
			this.SwitchSlotSelected.SafeInvoke();
		}
	}
}
