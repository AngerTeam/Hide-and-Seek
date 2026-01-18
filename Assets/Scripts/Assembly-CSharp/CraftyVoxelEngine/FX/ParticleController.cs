using System;
using UnityEngine;

namespace CraftyVoxelEngine.FX
{
	[ExecuteInEditMode]
	public class ParticleController : IDisposable
	{
		private ObjectPool<ParticleHolder> lightHolders_;

		private ObjectPool<ParticleHolder> hardHolders_;

		private short lightEmitMin_;

		private short lightEmitMax_;

		private short hardEmitMin_;

		private short hardEmitMax_;

		private GameObject ParticleWrapper;

		public Material Material { get; private set; }

		public ParticleController(int LMin, int LMax, int HMin, int HMax)
		{
			lightHolders_ = new ObjectPool<ParticleHolder>();
			hardHolders_ = new ObjectPool<ParticleHolder>();
			lightEmitMin_ = (short)LMin;
			lightEmitMax_ = (short)LMax;
			hardEmitMin_ = (short)HMin;
			hardEmitMax_ = (short)HMax;
			ParticleWrapper = new GameObject("FX:Particles");
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(ParticleWrapper);
			}
		}

		public void SetMaterial(Material material)
		{
			Material = material;
		}

		private void InitHolder(ParticleHolder holder, bool big)
		{
			if (!holder.Inited)
			{
				if (big)
				{
					holder.Init(Material, Vector3.zero, ParticleWrapper, true, 1.5f, hardEmitMin_, hardEmitMax_);
					holder.TimeOut += ReleaseBigHolder;
				}
				else
				{
					holder.Init(Material, Vector3.zero, ParticleWrapper, false, 0.6f, lightEmitMin_, lightEmitMax_);
					holder.TimeOut += ReleaseHolder;
				}
			}
		}

		private void ReleaseHolder(ParticleHolder holder)
		{
			lightHolders_.Release(holder);
			holder.SetTag("Pool_LT");
		}

		private void ReleaseBigHolder(ParticleHolder holder)
		{
			hardHolders_.Release(holder);
			holder.SetTag("Pool_BG");
		}

		public void Emit(Vector3 position, bool big)
		{
			Emit(position, big, new Vector2(0f, 0f));
		}

		public void Emit(Vector3 position, bool big, Vector2 UV)
		{
			ObjectPool<ParticleHolder> objectPool = ((!big) ? lightHolders_ : hardHolders_);
			ParticleHolder particleHolder = objectPool.Get();
			InitHolder(particleHolder, big);
			particleHolder.SetPosition(position);
			particleHolder.Play();
			particleHolder.SetTag(null);
		}

		public void Dispose()
		{
			hardHolders_.Dispose();
			lightHolders_.Dispose();
			UnityEngine.Object.Destroy(ParticleWrapper);
		}
	}
}
