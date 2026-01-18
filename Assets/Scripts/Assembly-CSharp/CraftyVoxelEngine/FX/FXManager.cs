using UnityEngine;

namespace CraftyVoxelEngine.FX
{
	public class FXManager : PermanentSingleton
	{
		private Material paticleMaterial_;

		public ParticleController ParticleController { get; private set; }

		public override void OnDataLoaded()
		{
			ParticleController = new ParticleController(5, 15, 40, 60);
		}

		public void InitParticleMaterial(Material material)
		{
			paticleMaterial_ = material;
			ParticleController.SetMaterial(paticleMaterial_);
		}

		private void AssignAtlas()
		{
			VoxelLoader voxelLoader = SingletonManager.Get<VoxelLoader>();
			paticleMaterial_.mainTexture = voxelLoader.Atlas;
		}

		public override void Dispose()
		{
			ParticleController.Dispose();
		}
	}
}
