using System;
using CraftyEngine.States;
using DG.Tweening;
using DG.Tweening.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace PlayerCameraModule
{
	public class TransitionalCameraState : CameraState
	{
		private TweenerCore<float, float, FloatOptions> distanceTween_;

		private TweenerCore<Vector3, Vector3, VectorOptions> targetOffsetTween_;

		private TweenerCore<Vector3, Vector3, VectorOptions> targetPositionTween_;

		public Vector3 TargetPosition { get; set; }

		public float Distance { get; set; }

		public float Duration { get; set; }

		public bool IsComplete { get; private set; }

		public bool IsTweenTargetPosition { get; set; }

		public TransitionalCameraState(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: base("TransitionalCameraState", camera, cameraInputModel)
		{
			Duration = 0.7f;
		}

		public override Transaction AddTransaction(State target, Func<bool> check = null)
		{
			Transaction transaction = base.AddTransaction(target, check);
			transaction.AddCondition(() => IsComplete);
			return transaction;
		}

		public override void Update()
		{
			if (base.Target != null && !IsTweenTargetPosition)
			{
				targetPosition_ = Vector3.SmoothDamp(targetPosition_, base.Target.position, ref positionVelocity_, positionSmoothTime_);
				camera_.SetTarget(targetPosition_);
			}
		}

		protected override void OnEnter()
		{
			base.OnEnter();
			if (base.Target != null)
			{
				targetPosition_ = camera_.Target;
			}
			IsComplete = false;
			InitTweeners();
			cameraInputModel_.EnabledByState = false;
		}

		protected override void OnExit()
		{
			cameraInputModel_.EnabledByState = true;
			KillTweens();
			base.OnExit();
		}

		private void InitTweeners()
		{
			KillTweens();
			if (IsTweenTargetPosition)
			{
				targetPositionTween_ = DOTween.To(() => camera_.Target, delegate(Vector3 o)
				{
					camera_.SetTarget(o);
				}, TargetPosition, Duration).SetEase(Ease.InOutQuad).SetLoops(1)
					.OnComplete(delegate
					{
						IsComplete = true;
						targetPositionTween_ = null;
					});
			}
			targetOffsetTween_ = DOTween.To(() => camera_.TargetOffset, delegate(Vector3 o)
			{
				camera_.SetTargetOffset(o);
			}, base.TargetOffset, Duration).SetEase(Ease.InOutQuad).OnUpdate(delegate
			{
				Vector3 resultOffset2;
				if (CheckTargetOffsetObstacle(camera_.TargetOffset, out resultOffset2))
				{
					camera_.SetTargetOffset(resultOffset2);
				}
			})
				.SetLoops(1)
				.OnComplete(delegate
				{
					IsComplete = true;
					targetOffsetTween_ = null;
				});
			float endValue = Distance;
			Vector3 resultOffset;
			if (CheckTargetOffsetObstacle(base.TargetOffset, out resultOffset))
			{
				endValue = CorrectNearestDistance(resultOffset, Distance);
			}
			distanceTween_ = DOTween.To(() => camera_.Distance, delegate(float d)
			{
				camera_.Distance = d;
			}, endValue, Duration).SetLoops(1).SetEase(Ease.InOutQuad)
				.OnUpdate(delegate
				{
					CheckDistanceObstacle();
				})
				.OnComplete(delegate
				{
					IsComplete = true;
					distanceTween_ = null;
				});
		}

		private void KillTweens()
		{
			if (distanceTween_ != null)
			{
				distanceTween_.Kill();
			}
			if (targetOffsetTween_ != null)
			{
				targetOffsetTween_.Kill();
			}
			if (targetPositionTween_ != null)
			{
				targetPositionTween_.Kill();
			}
		}
	}
}
