using System;
using System.Collections.Generic;
using InventoryModule;
using PlayerModule;
using UnityEngine;

namespace ArticulViewModule
{
	public class ArtikulItemViewManager : Singleton
	{
		private Dictionary<int, Type> handRenderers_;

		public override void Init()
		{
			handRenderers_ = new Dictionary<int, Type>();
			RegisterBuilder<BoxArticulView>(1);
			RegisterBuilder<VoxelArticulView>(3);
			RegisterBuilder<ToolArticulView>(2);
			RegisterBuilder<BillboardArticulView>(4);
		}

		public void RegisterBuilder<T>(int name) where T : ArticulViewBase
		{
			handRenderers_[name] = typeof(T);
		}

		public bool GetWorldOffset(int articulId, out Vector3 position, out float scale)
		{
			switch (GetRendererType(articulId))
			{
			case 3:
				position = new Vector3(0.4f, 0.4f, 0.4f);
				scale = 1f;
				return true;
			case 2:
				position = Vector3.zero;
				scale = 2.5f;
				return true;
			default:
				position = Vector3.zero;
				scale = 1f;
				return false;
			}
		}

		public int GetRendererType(int articulId)
		{
			ArtikulsEntries value;
			if (!InventoryContentMap.Artikuls.TryGetValue(articulId, out value))
			{
				return 0;
			}
			if (value.type_id == 3 || value.type_id == 4)
			{
				return 2;
			}
			if ((ushort)value.voxel_id != 0)
			{
				return 3;
			}
			return 4;
		}

		public ArticulViewBase GetRenderer(int articulId)
		{
			int rendererType = GetRendererType(articulId);
			ArticulViewBase articulViewBase = (ArticulViewBase)Activator.CreateInstance(handRenderers_[rendererType]);
			articulViewBase.type = rendererType;
			return articulViewBase;
		}
	}
}
