using System;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class SuperVoxelRigidBody : VoxelRigidBody
	{
		private const float FRICTION = 0.4f;

		private const float FADING = 0.4f;

		private bool bounce_;

		private bool reflect_;

		public event Action<Vector3> FellOnGroundExtend;

		public SuperVoxelRigidBody(float gravity, float maxFallSpeed, float height, float radius, bool bounce)
			: base(gravity, maxFallSpeed, height, radius)
		{
			bounce_ = bounce;
			reflect_ = bounce_;
		}

		protected void FixedUpdate()
		{
			Vector3 newPosition_ = transform_.position;
			CheckGrounded(newPosition_);
			CheckBounceCollisions(ref newPosition_);
			CheckShapeTrigger(newPosition_);
			if (transform_ != null)
			{
				transform_.position = newPosition_ + velocity_ * Time.fixedDeltaTime;
			}
		}

		protected void OnGrounded(Vector3 position)
		{
			if (!bounce_)
			{
				velocity_ = Vector3.zero;
			}
			if (this.FellOnGroundExtend != null)
			{
				this.FellOnGroundExtend(position);
			}
		}

		internal bool CheckBounceCollisions(ref Vector3 newPosition_)
		{
			bool result = false;
			if (!bounce_)
			{
				return false;
			}
			Vector3 fromVector = newPosition_;
			VoxelKey GlobalKey;
			if (CheckCollision(newPosition_.MoveX(0f - checkRadius90_), out GlobalKey))
			{
				VoxelKey keyPos = new VoxelKey(fromVector);
				if (CheckReflection(keyPos, GlobalKey))
				{
					Vector3 reflectionNormal = GetReflectionNormal(keyPos, GlobalKey);
					ReflectVelocity(reflectionNormal);
				}
				newPosition_.x = (float)GlobalKey.x + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveX(checkRadius90_), out GlobalKey))
			{
				VoxelKey keyPos2 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos2, GlobalKey))
				{
					Vector3 reflectionNormal2 = GetReflectionNormal(keyPos2, GlobalKey);
					ReflectVelocity(reflectionNormal2);
				}
				newPosition_.x = (float)GlobalKey.x - radius90_;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveZ(0f - checkRadius90_), out GlobalKey))
			{
				VoxelKey keyPos3 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos3, GlobalKey))
				{
					Vector3 reflectionNormal3 = GetReflectionNormal(keyPos3, GlobalKey);
					ReflectVelocity(reflectionNormal3);
				}
				newPosition_.z = (float)GlobalKey.z + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveZ(checkRadius90_), out GlobalKey))
			{
				VoxelKey keyPos4 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos4, GlobalKey))
				{
					Vector3 reflectionNormal4 = GetReflectionNormal(keyPos4, GlobalKey);
					ReflectVelocity(reflectionNormal4);
				}
				newPosition_.z = (float)GlobalKey.z - radius90_;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveY(0f - checkRadius90_), out GlobalKey))
			{
				VoxelKey keyPos5 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos5, GlobalKey))
				{
					Vector3 reflectionNormal5 = GetReflectionNormal(keyPos5, GlobalKey);
					ReflectVelocity(reflectionNormal5);
				}
				newPosition_.y = (float)GlobalKey.y + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveY(checkRadius90_), out GlobalKey))
			{
				VoxelKey keyPos6 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos6, GlobalKey))
				{
					Vector3 reflectionNormal6 = GetReflectionNormal(keyPos6, GlobalKey);
					ReflectVelocity(reflectionNormal6);
				}
				newPosition_.y = (float)GlobalKey.y - radius90_;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveX(0f - checkRadius45_), out GlobalKey))
			{
				VoxelKey keyPos7 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos7, GlobalKey))
				{
					Vector3 reflectionNormal7 = GetReflectionNormal(keyPos7, GlobalKey);
					ReflectVelocity(reflectionNormal7);
				}
				newPosition_.x = (float)GlobalKey.x + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveX(checkRadius45_), out GlobalKey))
			{
				VoxelKey keyPos8 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos8, GlobalKey))
				{
					Vector3 reflectionNormal8 = GetReflectionNormal(keyPos8, GlobalKey);
					ReflectVelocity(reflectionNormal8);
				}
				newPosition_.x = (float)GlobalKey.x - radius90_;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveZ(0f - checkRadius45_), out GlobalKey))
			{
				VoxelKey keyPos9 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos9, GlobalKey))
				{
					Vector3 reflectionNormal9 = GetReflectionNormal(keyPos9, GlobalKey);
					ReflectVelocity(reflectionNormal9);
				}
				newPosition_.z = (float)GlobalKey.z + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveZ(checkRadius45_), out GlobalKey))
			{
				VoxelKey keyPos10 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos10, GlobalKey))
				{
					Vector3 reflectionNormal10 = GetReflectionNormal(keyPos10, GlobalKey);
					ReflectVelocity(reflectionNormal10);
				}
				newPosition_.z = (float)GlobalKey.z - radius90_;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveY(0f - checkRadius45_), out GlobalKey))
			{
				VoxelKey keyPos11 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos11, GlobalKey))
				{
					Vector3 reflectionNormal11 = GetReflectionNormal(keyPos11, GlobalKey);
					ReflectVelocity(reflectionNormal11);
				}
				newPosition_.y = (float)GlobalKey.y + radius90_ + 1f;
				result = true;
			}
			else if (CheckCollision(newPosition_.MoveY(checkRadius45_), out GlobalKey))
			{
				VoxelKey keyPos12 = new VoxelKey(fromVector);
				if (CheckReflection(keyPos12, GlobalKey))
				{
					Vector3 reflectionNormal12 = GetReflectionNormal(keyPos12, GlobalKey);
					ReflectVelocity(reflectionNormal12);
				}
				newPosition_.y = (float)GlobalKey.y - radius90_;
				result = true;
			}
			return result;
		}

		private bool CheckReflection(VoxelKey keyPos, VoxelKey keyCol)
		{
			if (keyPos.Equals(keyCol))
			{
				return false;
			}
			return true;
		}

		private Vector3 GetReflectionNormal(VoxelKey keyPos, VoxelKey keyCol)
		{
			return (keyPos - keyCol).ToVector();
		}

		private void ReflectVelocity(Vector3 normal)
		{
			if (reflect_)
			{
				velocity_ = Vector3.Reflect(velocity_, normal);
				ApplyFriction();
			}
		}

		private void ApplyFriction()
		{
			velocity_ *= 0.4f;
			float sqrMagnitude = velocity_.sqrMagnitude;
			if (sqrMagnitude < 0.4f)
			{
				velocity_ = Vector3.zero;
				reflect_ = false;
			}
		}
	}
}
