using System;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelRigidBody : IDisposable
	{
		public bool checkExtraPoins;

		public bool enabled = true;

		protected float gravity_;

		protected float height_;

		protected float maxFallSpeed_;

		protected float radius45_;

		protected float radius90_;

		protected float checkRadius45_;

		protected float checkRadius90_;

		protected Transform transform_;

		protected UnityEvent unityEvent_;

		protected VoxelManager manager_;

		protected Vector3 velocity_;

		private bool PlayerSpawned = true;

		private Vector3 shiftTest = default(Vector3);

		public float FallSpeed
		{
			get
			{
				return velocity_.y;
			}
		}

		public bool Grounded { get; private set; }

		public bool GroundedAtLeastOnce { get; private set; }

		public event Action FellOnGround;

		public event Action MovedShiftDistance;

		public VoxelRigidBody(float gravity, float maxFallSpeed, float height, float radius)
		{
			GroundedAtLeastOnce = false;
			VoxelEngine singlton;
			SingletonManager.Get<VoxelEngine>(out singlton);
			manager_ = singlton.Manager;
			gravity_ = gravity;
			maxFallSpeed_ = maxFallSpeed;
			height_ = height;
			radius90_ = radius;
			radius45_ = radius90_ * Mathf.Sin((float)Math.PI / 4f);
			checkRadius90_ = radius90_ - 0.01f;
			checkRadius45_ = radius45_ - 0.01f;
		}

		public bool CheckCollision(Vector3 vector3)
		{
			return manager_.HitCast(vector3);
		}

		public bool CheckCollision(Vector3 vector3, out VoxelKey GlobalKey)
		{
			GlobalKey = new VoxelKey(vector3);
			return manager_.HitCast(vector3);
		}

		public void Dispose()
		{
			if (unityEvent_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.FixedUpdate, FixedUpdate);
			}
		}

		internal void AddForce(Vector3 force)
		{
			velocity_ += force;
		}

		public void ResetVerticalForce()
		{
			velocity_.y = 0f;
		}

		internal void AddUpForce(float jumpSpeed_)
		{
			velocity_.y += jumpSpeed_;
		}

		public void DropVelocity()
		{
			velocity_.Set(0f, 1f, 0f);
		}

		internal void AutoUpdate(Transform transform)
		{
			transform_ = transform;
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.FixedUpdate, FixedUpdate);
		}

		internal void CheckGrounded(Vector3 currentPosition_)
		{
			Vector3 vector = currentPosition_.MoveY(-0.001f);
			Debug.DrawLine(currentPosition_, vector, Color.white, 0f, true);
			if (CheckCollision(vector.MoveX(checkRadius90_)) || CheckCollision(vector.MoveX(0f - checkRadius90_)) || CheckCollision(vector.MoveZ(checkRadius90_)) || CheckCollision(vector.MoveZ(0f - checkRadius90_)) || (checkExtraPoins && (CheckCollision(vector + new Vector3(0f - checkRadius45_, 0f, 0f - checkRadius45_)) || CheckCollision(vector + new Vector3(0f - checkRadius45_, 0f, 0f - checkRadius45_)) || CheckCollision(vector + new Vector3(checkRadius45_, 0f, 0f - checkRadius45_)) || CheckCollision(vector + new Vector3(0f - checkRadius45_, 0f, checkRadius45_)))))
			{
				if (!Grounded)
				{
					velocity_ = Vector3.zero;
					this.FellOnGround.SafeInvoke();
				}
				GroundedAtLeastOnce = true;
				Grounded = true;
			}
			else
			{
				Grounded = false;
			}
		}

		public void ApplyGravity()
		{
			if (!Grounded)
			{
				velocity_.y -= gravity_ * Time.fixedDeltaTime;
				if (velocity_.y < 0f - maxFallSpeed_)
				{
					velocity_.y = 0f - maxFallSpeed_;
				}
			}
		}

		internal bool CheckHeightCollisions(ref Vector3 newPosition_)
		{
			bool result = false;
			VoxelKey GlobalKey;
			if (CheckCollision(newPosition_, out GlobalKey))
			{
				newPosition_.y = GlobalKey.y + 1;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveY(height_), out GlobalKey))
			{
				newPosition_.y = (float)GlobalKey.y - height_;
				velocity_.y = 0f;
				result = true;
			}
			return result;
		}

		private void MoveByDif(ref Vector3 newPosition_, Vector3 vertex)
		{
			Vector3 vector = newPosition_ - vertex;
			vector.Normalize();
			float num = Vector3.Distance(newPosition_, vertex);
			float num2 = radius90_ - num;
			newPosition_ += vector * num2;
		}

		internal bool CheckSideCollisions(ref Vector3 newPosition_)
		{
			bool result = false;
			VoxelKey GlobalKey;
			if (checkExtraPoins)
			{
				if (CheckCollision(newPosition_ + new Vector3(0f - checkRadius45_, 0f, 0f - checkRadius45_), out GlobalKey))
				{
					MoveByDif(ref newPosition_, new Vector3(GlobalKey.x + 1, newPosition_.y, GlobalKey.z + 1));
					result = true;
				}
				else if (CheckCollision(newPosition_ + new Vector3(checkRadius45_, 0f, checkRadius45_), out GlobalKey))
				{
					MoveByDif(ref newPosition_, new Vector3(GlobalKey.x, newPosition_.y, GlobalKey.z));
					result = true;
				}
				else if (CheckCollision(newPosition_ + new Vector3(checkRadius45_, 0f, 0f - checkRadius45_), out GlobalKey))
				{
					MoveByDif(ref newPosition_, new Vector3(GlobalKey.x, newPosition_.y, GlobalKey.z + 1));
					result = true;
				}
				else if (CheckCollision(newPosition_ + new Vector3(0f - checkRadius45_, 0f, checkRadius45_), out GlobalKey))
				{
					MoveByDif(ref newPosition_, new Vector3(GlobalKey.x + 1, newPosition_.y, GlobalKey.z));
					result = true;
				}
			}
			if (CheckCollision(newPosition_.MoveX(0f - checkRadius90_), out GlobalKey))
			{
				newPosition_.x = (float)GlobalKey.x + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveX(checkRadius90_), out GlobalKey))
			{
				newPosition_.x = (float)GlobalKey.x - radius90_;
				result = true;
			}
			if (CheckCollision(newPosition_.MoveZ(0f - checkRadius90_), out GlobalKey))
			{
				newPosition_.z = (float)GlobalKey.z + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveZ(checkRadius90_), out GlobalKey))
			{
				newPosition_.z = (float)GlobalKey.z - radius90_;
				result = true;
			}
			return result;
		}

		private void FixedUpdate()
		{
			Vector3 newPosition_ = transform_.position;
			CheckGrounded(newPosition_);
			ApplyGravity();
			CheckHeightCollisions(ref newPosition_);
			CheckShapeTrigger(newPosition_);
			transform_.position = newPosition_ + velocity_ * Time.fixedDeltaTime;
		}

		public void CheckShapeTrigger(Vector3 point)
		{
			if ((point - shiftTest).sqrMagnitude > 0.2f)
			{
				if (!PlayerSpawned)
				{
					this.MovedShiftDistance.SafeInvoke();
				}
				else
				{
					PlayerSpawned = false;
				}
				shiftTest = point;
			}
		}
	}
}
