using System;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine;
using UnityEngine;

namespace MyPlayerInput
{
	public class JumpController
	{
		public GameObject playerGameObject;

		public VoxelRigidBody voxelRigidBody;

		private AutoJumpController autoJumpController_;

		private KeyboardInputManager inputManager_;

		private float jumpSpeed_;

		private float lastGroundedTime_;

		private Vector3 lastGroundPosition_;

		private SoundLogic soundLogic;

		private MyPlayerInputModel model_;

		public event Action<Vector3, Vector3> FallFromCriticalHeight;

		public JumpController(MyPlayerInputModel myPlayerInputModel, VoxelRigidBody voxelRigidBody, SoundLogic soundLogic, int layer)
		{
			model_ = myPlayerInputModel;
			this.soundLogic = soundLogic;
			this.voxelRigidBody = voxelRigidBody;
			autoJumpController_ = new AutoJumpController(myPlayerInputModel.autoJumpDelay, myPlayerInputModel.autoJumpResetDelay);
			if (model_.criticalHeight <= 1f)
			{
				model_.criticalHeight = float.MaxValue;
			}
			jumpSpeed_ = Mathf.Sqrt(model_.gravity * model_.jumpHeight * 2f);
			SingletonManager.Get<KeyboardInputManager>(out inputManager_, layer);
			inputManager_.ButtonPressed += HandleButtonPressed;
			inputManager_.ButtonReleased += HandleButtonReleased;
		}

		internal void HandleFellOnGround()
		{
			autoJumpController_.enabled = true;
			model_.jumping = false;
			float num = lastGroundPosition_.y - playerGameObject.transform.position.y;
			if (num > model_.criticalHeight)
			{
				if (this.FallFromCriticalHeight == null)
				{
					Log.Info("Player fall from critical height");
				}
				else
				{
					this.FallFromCriticalHeight(playerGameObject.transform.position, playerGameObject.transform.eulerAngles);
				}
			}
			soundLogic.CheckLanding(num);
		}

		internal void HandleInput(Vector3 checkPosition, Vector3 checkPosition2)
		{
			if (autoJumpController_.HandleInput(checkPosition, checkPosition2, voxelRigidBody))
			{
				Log.Info("Auto Jump!");
				Jump();
			}
		}

		internal void Reset(Vector3 position)
		{
			lastGroundedTime_ = Time.unscaledTime;
			lastGroundPosition_ = position;
		}

		internal void Update(Vector2 input)
		{
			autoJumpController_.Update(input);
		}

		private void HandleButtonPressed(object sender, InputEventArgs e)
		{
			if (e.keyCode == KeyCode.Space && model_.jumpEnabled)
			{
				if (Time.unscaledTime - lastGroundedTime_ < 0.35f || voxelRigidBody.Grounded)
				{
					Jump();
				}
				model_.movingUp = true;
			}
		}

		private void HandleButtonReleased(object sender, InputEventArgs e)
		{
			if (e.keyCode == KeyCode.Space)
			{
				model_.movingUp = false;
			}
		}

		private void Jump()
		{
			if (!model_.jumping)
			{
				Vector3 position = playerGameObject.transform.position;
				position.y = lastGroundPosition_.y;
				playerGameObject.transform.position = position;
				voxelRigidBody.AddUpForce(jumpSpeed_);
				autoJumpController_.enabled = false;
				model_.jumping = true;
				lastGroundedTime_ = 0f;
			}
		}
	}
}
