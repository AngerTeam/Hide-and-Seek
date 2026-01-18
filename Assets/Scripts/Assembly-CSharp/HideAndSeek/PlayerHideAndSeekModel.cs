using System;
using CraftyVoxelEngine;
using Extensions;
using UnityEngine;

namespace HideAndSeek
{
	[Serializable]
	public class PlayerHideAndSeekModel
	{
		[SerializeField]
		private HideAndSeekRole role_;

		public bool isLastHider;

		[SerializeField]
		private int hideVoxelId_;

		[SerializeField]
		private bool isHidden_;

		public VoxelKey LastHidePosition { get; private set; }

		public VoxelKey HidePosition { get; private set; }

		public byte HideRotation { get; private set; }

		public int HideVoxelId
		{
			get
			{
				return hideVoxelId_;
			}
			set
			{
				if (hideVoxelId_ != value)
				{
					hideVoxelId_ = value;
					HideVoxelsEntries value2;
					if (HideAndSeekContentMap.HideVoxels.TryGetValue(hideVoxelId_, out value2))
					{
						VoxelId = value2.voxel_id;
						ArtikulId = value2.artikul.id;
					}
					else
					{
						VoxelId = 0;
						ArtikulId = 0;
					}
					this.SelectedHideVoxelChanged.SafeInvoke();
				}
			}
		}

		public int VoxelId { get; private set; }

		public int ArtikulId { get; private set; }

		public bool IsHidden
		{
			get
			{
				return isHidden_;
			}
			private set
			{
				if (isHidden_ != value)
				{
					isHidden_ = value;
					this.HiddenChanged.SafeInvoke();
				}
			}
		}

		public HideAndSeekRole Role
		{
			get
			{
				return role_;
			}
			set
			{
				if (role_ != value)
				{
					role_ = value;
					this.RoleChanged.SafeInvoke();
				}
			}
		}

		public bool IsHiderOrMonstr
		{
			get
			{
				return IsHider || IsMonstr;
			}
		}

		public bool IsHider
		{
			get
			{
				return role_ == HideAndSeekRole.Hider;
			}
		}

		public bool IsMonstr
		{
			get
			{
				return role_ == HideAndSeekRole.Monstr;
			}
		}

		public bool IsSeeker
		{
			get
			{
				return role_ == HideAndSeekRole.Seeker;
			}
		}

		public bool IsIdle
		{
			get
			{
				return role_ == HideAndSeekRole.Idle;
			}
		}

		public bool HasItems
		{
			get
			{
				return IsSeeker || IsMonstr || IsIdle;
			}
		}

		public bool HasVoxel
		{
			get
			{
				return IsMonstr || IsHider || IsHidden;
			}
		}

		public event Action HiddenChanged;

		public event Action SelectedHideVoxelChanged;

		public event Action RoleChanged;

		public void Appear()
		{
			IsHidden = false;
			HidePosition = VoxelKey.zero;
			HideRotation = 0;
		}

		public void Hide(VoxelKey position, byte rotation)
		{
			HidePosition = position;
			LastHidePosition = HidePosition;
			HideRotation = rotation;
			IsHidden = true;
		}

		public void ReportSelectedHideVoxelChanged()
		{
			this.SelectedHideVoxelChanged.SafeInvoke();
		}
	}
}
