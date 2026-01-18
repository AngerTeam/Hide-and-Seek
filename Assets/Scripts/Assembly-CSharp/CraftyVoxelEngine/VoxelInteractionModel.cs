using System;
using Extensions;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelInteractionModel : Singleton
	{
		public float selectedItemDigRate;

		public int selectedItemDamageCorrectType;

		public int selectedItemDamageWrongType;

		public int selectedItemDamageType;

		public float selectedItemDistance;

		public ushort buildVoxelId;

		public bool rayHitSuccess;

		public Vector3 point;

		public ushort value;

		public byte rotation;

		public VoxelData data;

		public VoxelKey globalKey;

		public VoxelRaycastHit rayHit;

		public Vector3 direction;

		public bool inputEnabled;

		public int maxHeight = 255;

		public int maxWidth = 255;

		public bool isCreativeMode;

		public bool allowBuild = true;

		public bool allowDig = true;

		public bool supressDig;

		public bool interactionEnabled;

		private bool digging_;

		public bool silentLogic;

		public bool Digging
		{
			get
			{
				return digging_;
			}
			set
			{
				if (value != digging_)
				{
					digging_ = value;
					if (digging_)
					{
						this.DigStarted.SafeInvoke();
					}
					else
					{
						this.DigEnded.SafeInvoke();
					}
				}
			}
		}

		public event Action DigStarted;

		public event Action DigEnded;
	}
}
