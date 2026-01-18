using System.Collections.Generic;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelController
	{
		public VoxelView view;

		public VoxelData data;

		public VoxelKey globalKey;

		public VoxelKey chunkKey;

		public byte rotation;

		public int value;

		public int maxHealth;

		public int curHealth;

		public bool destroyed;

		public bool indestructable;

		public bool Locked;

		public float timeOut;

		public bool hideObjects;

		public List<GameObject> ObjectsForHide { get; private set; }

		public VoxelController()
		{
			view = new VoxelView();
			indestructable = false;
			ObjectsForHide = new List<GameObject>();
		}

		public void Init(VoxelData cur, VoxelKey key, byte rot)
		{
			destroyed = false;
			hideObjects = false;
			data = cur;
			value = cur.VoxelID;
			maxHealth = cur.Durability;
			curHealth = cur.Durability;
			indestructable = maxHealth <= 0;
			globalKey = key;
			chunkKey = key / 16f;
			rotation = rot;
			view.SetCracks(cur, key, rot);
		}

		public void DoHit(int damage)
		{
			if (indestructable)
			{
				return;
			}
			bool flag = curHealth == maxHealth && damage > maxHealth;
			curHealth -= damage;
			if (curHealth <= 0)
			{
				destroyed = true;
				curHealth = 0;
			}
			if (view != null)
			{
				if (data.Replaceble || flag)
				{
					view.Hide();
					return;
				}
				view.SetCracks(globalKey, data.ModelID, rotation);
				float num = (float)curHealth / (float)maxHealth;
				view.CracksView.cracks.name = string.Format("Cracks {0} [{1}/{2}]", num, curHealth, maxHealth);
				view.SetProgress(1f - num);
			}
		}

		public void Hide()
		{
			view.CracksView.cracks.name = "Cracks hidden";
			view.Hide();
			if (!hideObjects)
			{
				return;
			}
			foreach (GameObject item in ObjectsForHide)
			{
				if (item != null)
				{
					item.SetActive(false);
				}
			}
			ObjectsForHide.Clear();
		}
	}
}
