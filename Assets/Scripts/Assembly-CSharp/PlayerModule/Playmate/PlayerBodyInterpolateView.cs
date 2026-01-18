using System;
using Animations;
using CraftyEngine.Infrastructure;
using DG.Tweening;
using MyPlayerInput;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlayerBodyInterpolateView : IDisposable
	{
		public bool enabled;

		public float rate;

		private Animator animator_;

		private float lerpValue_;

		private Vector3 nextPosition_;

		private Quaternion nextRotation_;

		private Quaternion nextTorsoRotation_;

		private Vector3 previousPosition_;

		private Quaternion previousRotation_;

		private Quaternion previousTorsoRotation_;

		private float speedMax_;

		private int speedPower_;

		private UnityEvent unityEvent_;

		private bool inited_;

		private IPlaymatePositionController playmatePositionController_;

		private PlayerStatsModel model_;

		private Func<Vector3, float> GetDistance_;

		private bool Active
		{
			get
			{
				return animator_ != null && animator_.isInitialized && animator_.gameObject.activeInHierarchy;
			}
		}

		public PlayerBodyInterpolateView(PlayerStatsModel model, IPlaymatePositionController playmatePositionController)
		{
			playmatePositionController_ = playmatePositionController;
			model_ = model;
			rate = DataStorage.updateRateView;
			speedPower_ = MyPlayerInputContentMap.PlayerSettings.moveSpeedPower * 2;
			speedMax_ = MyPlayerInputContentMap.PlayerSettings.moveSpeed;
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			unityEvent_.Subscribe(UnityEventType.LateUpdate, UnityLateUpdate);
			Stop();
			lerpValue_ = 1f;
			inited_ = false;
			GetDistance_ = ((!AnimationsContentMap.AnimationSettings.allowVericalRunAnimations) ? new Func<Vector3, float>(GetDistanceFlat) : new Func<Vector3, float>(GetDistance3D));
		}

		public void Dispose()
		{
			if (animator_ != null)
			{
				animator_.SetFloat("WalkSpeed", 0f);
			}
			if (unityEvent_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
				unityEvent_.Unsubscribe(UnityEventType.LateUpdate, UnityLateUpdate);
			}
		}

		private void SetAnimator(Animator animator)
		{
			animator_ = animator;
			if (animator_ != null)
			{
				animator_.cullingMode = ((!model_.IsMyPlayer) ? AnimatorCullingMode.CullCompletely : AnimatorCullingMode.AlwaysAnimate);
			}
		}

		private void SetWalkSpeed(float speed)
		{
			if (Active)
			{
				model_.visual.walkSpeed = speed;
				float value = ((!model_.jumping) ? speed : 0f);
				animator_.SetFloat("WalkSpeed", value);
				if (!model_.visual.Statinoary && animator_.speed != 1f)
				{
					animator_.speed = 1f;
				}
			}
		}

		private float EaseOutCubic(float t, int power)
		{
			return (float)((double)(t -= 1f) * Math.Pow(t, power) + 1.0);
		}

		private float GetDistance3D(Vector3 position)
		{
			return Vector3.Distance(previousPosition_, position);
		}

		private float GetDistanceFlat(Vector3 position)
		{
			return Vector3.Distance(previousPosition_.ResetY(), position.ResetY());
		}

		public void SetTransform(Vector3 position)
		{
			nextPosition_ = position;
			playmatePositionController_.SetServerPosition(nextPosition_, nextRotation_);
		}

		public void UpdateStatus(Vector3 position, Vector3 rotation)
		{
			nextPosition_ = position;
			nextRotation_ = Quaternion.Euler(0f, rotation.y, 0f);
			float y = ClampTorsoRotation(rotation.x);
			nextTorsoRotation_ = Quaternion.Euler(0f, y, 0f);
			if (playmatePositionController_.Transform == null)
			{
				model_.moveSpeed = 0f;
				inited_ = true;
			}
			else if (enabled && inited_)
			{
				lerpValue_ = 0f;
				previousPosition_ = playmatePositionController_.Transform.position;
				previousRotation_ = playmatePositionController_.Transform.rotation;
				float num = GetDistance_(position);
				float num2 = num / rate / speedMax_;
				if (speedPower_ > 0)
				{
					num2 = EaseOutCubic(num2, speedPower_);
				}
				if (Math.Abs(model_.moveSpeed - num2) > 0.01f)
				{
					DOTween.To(() => model_.moveSpeed, delegate(float s)
					{
						model_.moveSpeed = s;
					}, num2, DataStorage.updateRateView).SetEase(Ease.Linear);
				}
			}
			else
			{
				inited_ = true;
				playmatePositionController_.SetServerPosition(nextPosition_, nextRotation_);
				previousPosition_ = nextPosition_;
				previousRotation_ = nextRotation_;
				previousTorsoRotation_ = nextTorsoRotation_;
			}
		}

		private void UnityUpdate()
		{
			if (!enabled || !inited_)
			{
				return;
			}
			lerpValue_ += Time.deltaTime / rate;
			if (playmatePositionController_.Transform == null)
			{
				model_.moveSpeed = 0f;
				SetWalkSpeed(model_.moveSpeed);
				return;
			}
			if (lerpValue_ < 1f)
			{
				playmatePositionController_.SetServerPosition(Vector3.Lerp(previousPosition_, nextPosition_, lerpValue_), (!model_.IsMyPlayer) ? Quaternion.Lerp(previousRotation_, nextRotation_, lerpValue_) : nextRotation_);
				previousTorsoRotation_ = ((!model_.IsMyPlayer) ? Quaternion.Lerp(previousTorsoRotation_, nextTorsoRotation_, lerpValue_) : nextTorsoRotation_);
			}
			else
			{
				playmatePositionController_.SetServerPosition(nextPosition_, nextRotation_);
				previousTorsoRotation_ = nextTorsoRotation_;
			}
			SetWalkSpeed(model_.moveSpeed);
		}

		private void UnityLateUpdate()
		{
			if (enabled && inited_ && model_.visual.TorsoBone != null)
			{
				model_.visual.TorsoBone.rotation *= previousTorsoRotation_;
			}
		}

		private float ClampTorsoRotation(float torsoRotation)
		{
			float num = 0f - PlayerContentMap.PlayerEntity.torsoMinVerticalAngle;
			if (torsoRotation > 0f && torsoRotation <= 90f && torsoRotation > num)
			{
				torsoRotation = num;
			}
			float num2 = 360f - PlayerContentMap.PlayerEntity.torsoMaxVerticalAngle;
			if (torsoRotation > 270f && torsoRotation <= 360f && torsoRotation < num2)
			{
				torsoRotation = num2;
			}
			return torsoRotation;
		}

		public void Reset()
		{
			inited_ = false;
		}

		public void Stop()
		{
			model_.moveSpeed = 0f;
			SetWalkSpeed(0f);
		}

		public void UpdateGameObject()
		{
			SetAnimator(model_.visual.Animator);
			SetTransform(model_.Position);
			UpdateStatus(model_.Position, model_.Rotation);
		}
	}
}
