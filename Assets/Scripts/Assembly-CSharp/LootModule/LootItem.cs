using System;
using ArticulViewModule;
using CraftyEngine.Utils;
using CraftyVoxelEngine;
using DG.Tweening;
using InventoryModule;
using UnityEngine;

namespace LootModule
{
	public class LootItem
	{
		public ArtikulItem item;

		public GameObject GameObject;

		public Vector3 initialPosition;

		public bool spawned;

		private static int totalId = 1;

		internal bool flyToPlayer;

		internal bool initial;

		internal VoxelKey? sourceVoxelGlobalKey;

		internal bool spawnFromCraft;

		internal bool spawnForUnet;

		internal string idFrom;

		public int Id { get; private set; }

		public VoxelRigidBody RigidBody { get; private set; }

		public ArtikulItemView view { get; private set; }

		public event EventHandler PositionChanged;

		public LootItem(ArtikulItem item, Vector3 position, int? id = null, float spawnedTime = 0.5f)
		{
			initialPosition = position;
			if (id.HasValue)
			{
				Id = id.Value;
				if (Id >= totalId)
				{
					totalId = Id + 1;
				}
			}
			else
			{
				Id = totalId;
				totalId++;
			}
			this.item = item;
			spawned = true;
			UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
			UnityTimer unityTimer = unityTimerManager.SetTimer(spawnedTime);
			unityTimer.Completeted += delegate
			{
				spawned = false;
			};
		}

		public void AddView(float lootScale = 0.2f)
		{
			GameObject = new GameObject();
			view = new ArtikulItemView(GameObject.transform, item.Entry, 0.2f, lootScale);
			GameObject.transform.position = initialPosition;
			if (view.View.IsBillboard)
			{
				view.View.ActivateBillboard();
			}
			else
			{
				DOTween.To(() => GameObject.transform.localEulerAngles, delegate(Vector3 r)
				{
					GameObject.transform.localEulerAngles = r;
				}, new Vector3(0f, 360f, 0f), 4f).SetEase(Ease.Linear).SetLoops(-1);
			}
			Vector3 localPosition = view.Container.localPosition;
			localPosition.y = 0.05f;
			view.Container.localPosition = localPosition;
			localPosition.y = 0.25f;
			DOTween.To(() => view.Container.localPosition, delegate(Vector3 p)
			{
				view.Container.localPosition = p;
			}, localPosition, 4f).SetEase(Ease.InOutQuad).SetLoops(-1, LoopType.Yoyo);
			RigidBody = new VoxelRigidBody(InventoryContentMap.CraftSettings.lootItemGravity, InventoryContentMap.CraftSettings.lootItemGravityMax, 0.2f, 0.2f);
			RigidBody.AutoUpdate(GameObject.transform);
			RigidBody.FellOnGround += HandleFellOnGround;
			float x = UnityEngine.Random.value * 0.8f - 0.4f;
			float z = UnityEngine.Random.value * 0.8f - 0.4f;
			Vector3 force = new Vector3(x, 1f, z);
			RigidBody.AddForce(force);
			GameObject.name = string.Format("Loot {0} x{2} ({1})", item.Entry.title, Id, item.Amount);
		}

		private void HandleFellOnGround()
		{
			if (this.PositionChanged != null)
			{
				this.PositionChanged(this, null);
			}
		}

		internal void Destroy()
		{
			RigidBody.FellOnGround -= HandleFellOnGround;
			RigidBody.Dispose();
			UnityEngine.Object.Destroy(GameObject);
			view.Dispose();
		}
	}
}
