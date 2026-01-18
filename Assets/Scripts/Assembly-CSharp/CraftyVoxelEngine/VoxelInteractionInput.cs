using System;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelInteractionInput : IDisposable
	{
		private VoxelInteractionModel model_;

		private VoxelInteractionLogic logic_;

		private VoxelInteractionController controller_;

		private float nextAuroDigMark_;

		private int digStartDistance_;

		private UnityEvent unityEvent_;

		private InputManager inputManager_;

		public event Action<InteractiveVoxelArgs> InteractiveVoxelClicked;

		public VoxelInteractionInput(VoxelInteractionModel model, VoxelInteractionLogic logic, VoxelInteractionController controller)
		{
			model_ = model;
			logic_ = logic;
			controller_ = controller;
			digStartDistance_ = 20;
			SetDefaultDamage();
			SingletonManager.Get<UnityEvent>(out unityEvent_, 1);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			SingletonManager.Get<InputManager>(out inputManager_, 1);
			inputManager_.PointerClicked += HandleClick;
			inputManager_.MouseRightClick += HandleRightClick;
			inputManager_.PointerHoldStart += HandleHoldStart;
			inputManager_.PointerHoldEnd += HandleHoldEnd;
		}

		public void SetDefaultDamage()
		{
			SetDamage(10);
		}

		public void SetDamage(int damage, float delta = 0.3f)
		{
			model_.selectedItemDamageWrongType = damage;
			model_.selectedItemDamageCorrectType = damage;
			model_.selectedItemDigRate = delta;
		}

		private void Update()
		{
			if (model_.interactionEnabled && model_.Digging && Time.time > nextAuroDigMark_ && logic_.CanDig(false))
			{
				controller_.HitVoxel();
				nextAuroDigMark_ = Time.time + model_.selectedItemDigRate;
			}
		}

		public void HandleRightClick(bool force)
		{
			if ((force || (model_.inputEnabled && model_.interactionEnabled)) && logic_.CanDig(false))
			{
				controller_.PopVoxel();
			}
		}

		private void HandleRightClick(object sender, InputEventArgs args)
		{
			HandleRightClick(false);
		}

		public void HandleClick(object sender, InputEventArgs args)
		{
			if (model_.inputEnabled)
			{
				HandleClick();
			}
		}

		public void HandleClick(bool force = false)
		{
			if (force || model_.interactionEnabled)
			{
				if (this.InteractiveVoxelClicked != null && logic_.IsInteractive())
				{
					this.InteractiveVoxelClicked(new InteractiveVoxelArgs(model_.data.BuildingID, model_.globalKey));
				}
				else if (logic_.AllowBuild())
				{
					byte rotation;
					controller_.SetVoxel(model_.buildVoxelId, out rotation);
				}
			}
		}

		public bool ValidateHold(InputEventArgs args)
		{
			return Vector2.Distance(args.holdStartPosition, args.pointerPosition) < (float)digStartDistance_;
		}

		public void HandleHoldStart(object sender, InputEventArgs args)
		{
			if (model_.inputEnabled && model_.interactionEnabled && (!CompileConstants.MOBILE || ValidateHold(args)))
			{
				model_.Digging = true;
			}
		}

		internal void HandleHoldEnd(object sender, InputEventArgs args)
		{
			if (model_.inputEnabled)
			{
				model_.Digging = false;
			}
		}

		public void ActionButtonHoldStarted()
		{
			if (model_.interactionEnabled)
			{
				model_.Digging = true;
			}
		}

		public void ActionButtonHoldEnded()
		{
			model_.Digging = false;
		}

		public void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			inputManager_.PointerClicked -= HandleClick;
			inputManager_.MouseRightClick -= HandleRightClick;
			inputManager_.PointerHoldStart -= HandleHoldStart;
			inputManager_.PointerHoldEnd -= HandleHoldEnd;
		}
	}
}
