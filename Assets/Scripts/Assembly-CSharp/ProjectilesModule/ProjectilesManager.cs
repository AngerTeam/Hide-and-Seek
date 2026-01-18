using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyVoxelEngine;
using Extensions;
using UnityEngine;

namespace ProjectilesModule
{
	public class ProjectilesManager : Singleton
	{
		private UnityEvent unityEvent_;

		private VoxelEngine voxelEngine_;

		private PrefabsManager prefabsManager_;

		private TrajectoryPhysics trajectoryPhysics_;

		private List<ProjectileController> projectiles_;

		private LineRenderer lineRenderer;

		public event Action<Vector3, Vector3[]> ProjectileShotHappened;

		public event Action<int, Vector3, float> ProjectileHitHappened;

		public override void Init()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			projectiles_ = new List<ProjectileController>();
			trajectoryPhysics_ = new TrajectoryPhysics(voxelEngine_);
			prefabsManager_.Load("GrenadePrefabsHolder");
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public void DebugTrajectory(ITrajectory traj)
		{
			DebugTrajectory(traj, Color.green);
		}

		public void DebugTrajectory(ITrajectory traj, Color color)
		{
			if (lineRenderer == null)
			{
				CameraManager cameraManager = SingletonManager.Get<CameraManager>();
				lineRenderer = cameraManager.PlayerCamera.gameObject.AddComponent<LineRenderer>();
				lineRenderer.material = new Material(Shader.Find("Particles/Additive"));
				lineRenderer.SetWidth(0.05f, 0.05f);
			}
			lineRenderer.SetColors(color, color);
			List<Vector3> list = new List<Vector3>();
			for (float num = 0f; num < traj.EndTime; num += TrajectoryPhysics.timeStep / 5f)
			{
				list.Add(traj.GetPosition(num));
			}
			list.RemoveAt(0);
			list.RemoveAt(list.Count - 1);
			lineRenderer.SetVertexCount(list.Count);
			lineRenderer.SetPositions(list.ToArray());
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			foreach (ProjectileController item in projectiles_)
			{
				item.Dispose();
			}
			projectiles_.Clear();
		}

		public void Update()
		{
			for (int num = projectiles_.Count - 1; num >= 0; num--)
			{
				if (projectiles_[num].Finished)
				{
					projectiles_[num].Dispose();
					projectiles_.RemoveAt(num);
				}
				else
				{
					projectiles_[num].Update();
				}
			}
		}

		public ProjectileController SpawnProjectile(GameObject container, FileHolder fileHolder)
		{
			ProjectileController projectileController = new ProjectileController(container, fileHolder);
			projectiles_.Add(projectileController);
			return projectileController;
		}

		public TrajectoryChain CalculateTrajectory(Vector3 position, Vector3 target, float startSpeed, float timeLimit)
		{
			float angle = ProjectileUtility.CalcProjectileAngle(position, target, startSpeed);
			Vector3 vector = target - position;
			vector.y = 0f;
			vector.Normalize();
			Vector3 axis = Vector3.Cross(vector, Vector3.up);
			Vector3 velocity = Quaternion.AngleAxis(angle, axis) * vector;
			velocity *= startSpeed;
			return CalculateTrajectory(position, velocity, timeLimit);
		}

		public TrajectoryChain CalculateTrajectory(Vector3 position, Vector3 velocity, float timeLimit)
		{
			return trajectoryPhysics_.Calculate(position, velocity, timeLimit);
		}

		public void ReportProjectileShot(Vector3 direction, Vector3[] trajectory)
		{
			this.ProjectileShotHappened.SafeInvoke(direction, trajectory);
		}

		public void ReportProjectileHit(int clientProjectileId, Vector3 point, float radius)
		{
			this.ProjectileHitHappened.SafeInvoke(clientProjectileId, point, radius);
		}

		public void SetResponsedClientProjectileId(int clientProjectileId)
		{
			for (int i = 0; i < projectiles_.Count; i++)
			{
				ProjectileController projectileController = projectiles_[i];
				if (projectileController.sync && projectileController.clientProjectileId == 0)
				{
					projectileController.clientProjectileId = clientProjectileId;
					break;
				}
			}
		}

		public void ExplodeProjectile(int clientProjectileId)
		{
			for (int i = 0; i < projectiles_.Count; i++)
			{
				ProjectileController projectileController = projectiles_[i];
				if ((clientProjectileId > 0 && projectileController.clientProjectileId == clientProjectileId) || (clientProjectileId == 0 && projectileController.sync))
				{
					projectileController.Explode();
					projectileController.Dispose();
					projectiles_.RemoveAt(i);
					break;
				}
			}
		}
	}
}
