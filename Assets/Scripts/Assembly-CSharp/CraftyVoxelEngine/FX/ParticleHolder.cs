using System;
using CraftyEngine.Utils;
using Extensions;
using UnityEngine;
using UnityEngine.Rendering;

namespace CraftyVoxelEngine.FX
{
	public class ParticleHolder : IDisposable
	{
		private static int count;

		private static int tilesX_;

		private static int tilesY_;

		public static float tilesRate = 1f;

		public static float tilesOffset;

		public int id;

		private GameObject particleObject_;

		private ParticleSystem.TextureSheetAnimationModule textureSheet_;

		private int frames_;

		private UnityTimer timer_;

		private string name;

		public ParticleSystem ParticleSystem { get; private set; }

		public bool Inited { get; private set; }

		public event Action<ParticleHolder> TimeOut;

		public static void SetTileSize(int x, int y)
		{
			tilesX_ = Mathf.Max(1, x);
			tilesY_ = Mathf.Max(1, y);
		}

		public void SetTag(string tag)
		{
			if (string.IsNullOrEmpty(tag))
			{
				particleObject_.name = name;
			}
			particleObject_.name = name + " " + tag;
		}

		public void Init(Material material, Vector3 position, GameObject parent, bool big, float speed, short minCount, short maxCount = 0)
		{
			if (!Inited)
			{
				Inited = true;
				id = ++count;
				UnityTimerManager singlton;
				SingletonManager.Get<UnityTimerManager>(out singlton);
				timer_ = singlton.SetTimer();
				timer_.Completeted += HandleTimeOut;
				timer_.enable = false;
				timer_.repeat = true;
				name = "Particle emitter " + ((!big) ? "dot " : "box ") + id;
				particleObject_ = new GameObject(name);
				particleObject_.transform.SetParent(parent.transform);
				particleObject_.transform.localPosition = position;
				ParticleSystem = particleObject_.AddComponent<ParticleSystem>();
				ParticleSystem.startLifetime = 0.8f;
				ParticleSystem.startSpeed = 1.4f;
				ParticleSystem.startSize = 0.1f;
				ParticleSystem.gravityModifier = 0.5f;
				ParticleSystem.playOnAwake = false;
				ParticleSystem.loop = false;
				ParticleSystem.EmissionModule emission = ParticleSystem.emission;
				emission.rate = new ParticleSystem.MinMaxCurve(0f);
				if (maxCount < minCount)
				{
					maxCount = minCount;
				}
				ParticleSystem.Burst[] bursts = new ParticleSystem.Burst[1]
				{
					new ParticleSystem.Burst(0f, minCount, maxCount)
				};
				emission.SetBursts(bursts);
				emission.enabled = true;
				ParticleSystem.ShapeModule shape = ParticleSystem.shape;
				if (big)
				{
					shape.shapeType = ParticleSystemShapeType.Box;
					shape.randomDirection = true;
					shape.radius = 0.5f;
				}
				else
				{
					shape.shapeType = ParticleSystemShapeType.Sphere;
					shape.radius = 0.1f;
				}
				shape.enabled = true;
				frames_ = tilesX_ * tilesY_;
				Renderer component = ParticleSystem.GetComponent<Renderer>();
				component.sharedMaterial = material;
				component.receiveShadows = false;
				component.shadowCastingMode = ShadowCastingMode.Off;
				component.enabled = true;
			}
		}

		public void Play()
		{
			ParticleSystem.randomSeed = (uint)UnityEngine.Random.Range(1f, 4.2949673E+09f);
			ParticleSystem.Play();
			timer_.Reset();
			timer_.enable = true;
		}

		private void HandleTimeOut()
		{
			this.TimeOut.SafeInvoke(this);
			timer_.enable = false;
		}

		public bool isPlaying()
		{
			return ParticleSystem.isPlaying;
		}

		public void SetPosition(Vector3 position)
		{
			particleObject_.transform.position = position;
		}

		public void SetTile(int tile)
		{
			textureSheet_ = ParticleSystem.textureSheetAnimation;
			textureSheet_.animation = ParticleSystemAnimationType.WholeSheet;
			textureSheet_.frameOverTime = new ParticleSystem.MinMaxCurve((float)(tile / frames_) - 0.1f);
		}

		public void SetTile(Vector3 uv)
		{
			textureSheet_ = ParticleSystem.textureSheetAnimation;
			textureSheet_.animation = ParticleSystemAnimationType.WholeSheet;
			uv.x += tilesOffset;
			uv.y += tilesOffset;
			uv /= tilesRate;
			Vector2 vector = default(Vector2);
			vector.x = (float)tilesX_ * uv.x;
			vector.y = (float)tilesY_ * (1f - uv.y) - 1f;
			float num = vector.x + (float)tilesX_ * vector.y;
			textureSheet_.frameOverTime = new ParticleSystem.MinMaxCurve(num / (float)frames_);
		}

		public void Dispose()
		{
		}
	}
}
