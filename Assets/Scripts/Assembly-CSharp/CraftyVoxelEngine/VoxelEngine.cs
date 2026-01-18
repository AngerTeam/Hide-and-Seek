using System;
using System.Collections.Generic;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine.Content;
using CraftyVoxelEngine.FX;
using Extensions;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelEngine : PermanentSingleton
	{
		public static bool firstStart = true;

		private UnityEvent unityEvent_;

		private LogicVoxelManager logicVoxelManager_;

		private VoxelControllerManager controllerManager_;

		private MyPlayerStatsModel gameModel_;

		public Dictionary<int, Action<DataSerializable>> messageHandlers;

		private float power;

		public bool spawned;

		public bool anyChunkRendered;

		public VoxelCore core { get; private set; }

		public VoxelManager Manager { get; private set; }

		public VoxelSettings Settings { get; private set; }

		public VoxelViewManager ViewManager { get; private set; }

		public VoxelActions voxelActions { get; private set; }

		public VoxelEvents voxelEvents { get; private set; }

		public event Action EngineReset;

		public event Action<InteractiveVoxelArgs> InteractiveVoxelAdded;

		public event Action<InteractiveVoxelArgs> InteractiveVoxelRemoved;

		public event Action<RegionEventArgs> PlayerEnterTrigger;

		public event Action<MessageVoxelChanged> VoxelDestroyed;

		public event Action<MessageVoxelChanged> VoxelValueChanged;

		public VoxelEngine()
		{
			InitLog();
			core = new VoxelCore();
			messageHandlers = new Dictionary<int, Action<DataSerializable>>();
			voxelEvents = new VoxelEvents(core, messageHandlers);
			voxelActions = new VoxelActions(core, messageHandlers);
			Manager = core.manager;
			Settings = core.settings;
			voxelEvents.VoxelChanged += VoxelChanged;
			voxelEvents.InteractiveVoxelChanged += InteractChanged;
			ViewManager = new VoxelViewManager();
			voxelEvents.ChunkChanged += ChunkChanged;
			voxelEvents.ChunkChanged += ViewManager.ChunkChanged;
		}

		private void ChunkChanged(MessageChunkChanged message)
		{
			anyChunkRendered = true;
			voxelEvents.ChunkChanged -= ChunkChanged;
		}

		public static void CreateEngineManager(int layer)
		{
			SingletonManager.Add<VoxelEngine>(layer);
			SingletonManager.Add<RaycastManager>(layer);
			SingletonManager.Add<VoxelInteractionModel>(layer);
			SingletonManager.Add<VoxelInteraction>(layer);
			SingletonManager.Add<VoxelInteractionEffects>(layer);
			SingletonManager.Add<FXManager>(layer);
			SingletonManager.Add<VoxelControllerManager>(layer);
			SingletonManager.Add<VoxelLoader>(layer);
			SingletonManager.Add<LogicVoxelManager>(layer);
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			Reset();
			WaitForVoxelTreadTask waitForVoxelTreadTask = new WaitForVoxelTreadTask(core);
			waitForVoxelTreadTask.Start();
			core.StopMainCycle();
			core = null;
			voxelEvents = null;
			Manager = null;
			Settings = null;
			ViewManager = null;
			this.InteractiveVoxelAdded = null;
			this.InteractiveVoxelRemoved = null;
			this.VoxelDestroyed = null;
		}

		public override void Init()
		{
			GetSingleton<UnityEvent>(out unityEvent_);
			SingletonManager.TryGet<LogicVoxelManager>(out logicVoxelManager_);
			SingletonManager.TryGet<VoxelControllerManager>(out controllerManager_);
			SingletonManager.TryGet<MyPlayerStatsModel>(out gameModel_);
			ViewManager.Init();
			Reset();
		}

		public void Reset()
		{
			voxelEvents.ChunkChanged -= ChunkChanged;
			voxelEvents.ChunkChanged += ChunkChanged;
			Manager.lockRaycast = true;
			this.EngineReset.SafeInvoke();
			if (!firstStart)
			{
				voxelActions.ResetAll();
				ViewManager.Clear();
			}
			core.ShowRendererStatus();
			core.ResetRenderer();
			firstStart = false;
			if (logicVoxelManager_ != null)
			{
				logicVoxelManager_.Reset();
			}
			if (controllerManager_ != null)
			{
				controllerManager_.Reset();
			}
			anyChunkRendered = false;
			spawned = false;
		}

		public bool GetVoxelData(ushort voxelid, out VoxelData data)
		{
			if (Settings != null)
			{
				return Settings.GetData(voxelid, out data);
			}
			data = default(VoxelData);
			return false;
		}

		public Vector2 GetFirstTextureUv(int index, int texIndex)
		{
			if (Settings != null)
			{
				return Settings.GetFirstTextureUv(index, texIndex);
			}
			return Vector2.zero;
		}

		public void InteractChanged(MessageInteractiveVoxelChanged args)
		{
			VoxelData data;
			if (this.InteractiveVoxelAdded != null && Settings.GetData(args.newValue, out data) && data.BuildingID != 0 && data.Interactive)
			{
				this.InteractiveVoxelAdded(new InteractiveVoxelArgs(data.BuildingID, args.globalKey));
			}
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<VoxelContentMap>();
			power = VoxelContentMap.VoxelSettings.AOPower;
			Settings.SetPowerOfAO(power);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public override void OnLogicLoaded()
		{
		}

		public void TestTriggerRegion(Vector3 position)
		{
			VoxelRegion trigger = Manager.GetTrigger(new VoxelKey(position));
			if (trigger.type == 2 && this.PlayerEnterTrigger != null)
			{
				this.PlayerEnterTrigger(new RegionEventArgs(trigger));
			}
		}

		public void VoxelChanged(MessageVoxelChanged args)
		{
			VoxelData data2;
			if (args.oldValue != 0 && args.newValue == 0)
			{
				if (this.VoxelDestroyed != null)
				{
					this.VoxelDestroyed(args);
				}
				VoxelData data;
				if (this.InteractiveVoxelRemoved != null && Settings.GetData(args.oldValue, out data) && data.BuildingID != 0 && data.Interactive)
				{
					this.InteractiveVoxelRemoved(new InteractiveVoxelArgs(data.BuildingID, args.globalKey));
				}
			}
			else if (args.oldValue == 0 && args.newValue != 0 && this.InteractiveVoxelAdded != null && Settings.GetData(args.newValue, out data2) && data2.BuildingID != 0 && data2.Interactive)
			{
				this.InteractiveVoxelAdded(new InteractiveVoxelArgs(data2.BuildingID, args.globalKey));
			}
			if (this.VoxelValueChanged != null)
			{
				this.VoxelValueChanged(args);
			}
		}

		private void InitLog()
		{
			Log.CSVE("Library loading, using Library: VoxelCore " + Library.Version);
			int logLevel = 5;
			Library.SetLogLevel(logLevel);
		}

		private void Update()
		{
			voxelEvents.Update();
			ViewManager.Update();
			if (spawned)
			{
				Vector3 position = gameModel_.stats.Position;
				ViewManager.playerPos = position;
				voxelActions.SetViewPosition(position);
			}
		}

		public void UpdateOAPower(float step)
		{
			power += step;
			if (power > 1f)
			{
				power = 0f;
			}
			Log.Info("Current AO power: " + power);
			Settings.SetPowerOfAO(power);
			voxelActions.ReRenderAll();
		}

		public void FillRegion(VoxelRegion region, ushort value)
		{
			region.Update();
			FillRegion(region.min, region.max, value);
		}

		public void FillRegion(VoxelKey min, VoxelKey max, ushort value)
		{
			List<KeyedVoxel> list = new List<KeyedVoxel>();
			VoxelKey key = default(VoxelKey);
			key.x = min.x;
			while (key.x <= max.x)
			{
				key.y = min.y;
				while (key.y <= max.y)
				{
					key.z = min.z;
					while (key.z <= max.z)
					{
						list.Add(new KeyedVoxel(key, value));
						key.z++;
					}
					key.y++;
				}
				key.x++;
			}
			core.SetMultypleVoxels(list.ToArray());
		}

		public void ReplaceRegion(VoxelRegion region, int oldValue, int newValue)
		{
			region.Update();
			ReplaceRegion(region.min, region.max, oldValue, newValue);
		}

		public void ReplaceRegion(VoxelKey min, VoxelKey max, int oldValue, int newValue)
		{
			List<KeyedVoxel> list = new List<KeyedVoxel>();
			for (int i = min.x; i <= max.x; i++)
			{
				for (int j = min.z; j <= max.z; j++)
				{
					for (int k = min.y; k <= max.y; k++)
					{
						VoxelKey key = new VoxelKey(i, k, j);
						Voxel voxel;
						core.GetVoxel(key, out voxel);
						if (voxel.Value == oldValue)
						{
							list.Add(new KeyedVoxel(key, (ushort)newValue));
						}
					}
				}
			}
			core.SetMultypleVoxels(list.ToArray());
		}

		public void FillSphere(VoxelKey center, float radius, ushort value)
		{
			List<KeyedVoxel> list = new List<KeyedVoxel>();
			float num = radius * radius;
			VoxelKey voxelKey = center - (int)Mathf.Ceil(radius + 2f);
			VoxelKey voxelKey2 = center + (int)Mathf.Ceil(radius + 2f);
			VoxelKey voxelKey3 = default(VoxelKey);
			voxelKey3.x = voxelKey.x;
			while (voxelKey3.x <= voxelKey2.x)
			{
				voxelKey3.y = voxelKey.y;
				while (voxelKey3.y <= voxelKey2.y)
				{
					voxelKey3.z = voxelKey.z;
					while (voxelKey3.z <= voxelKey2.z)
					{
						if ((voxelKey3 - center).ToVector().sqrMagnitude < num)
						{
							list.Add(new KeyedVoxel(voxelKey3, value));
						}
						voxelKey3.z++;
					}
					voxelKey3.y++;
				}
				voxelKey3.x++;
			}
			core.SetMultypleVoxels(list.ToArray());
		}
	}
}
