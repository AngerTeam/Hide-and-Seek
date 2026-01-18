using System;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine.Content;
using UnityEngine;

namespace ShapesModule
{
	public class ShapeInteraction
	{
		private float rayCastDistance_;

		private CameraManager cameraManager_;

		public event EventHandler<ShapeEventArgs> InteractiveShapeClicked;

		public event EventHandler<ShapeEventArgs> InteractiveShapeTouched;

		public event EventHandler<ShapeEventArgs> InteractiveShapeEnter;

		public event EventHandler<ShapeEventArgs> InteractiveShapeExit;

		public ShapeInteraction()
		{
			ShapeManager singlton;
			SingletonManager.Get<ShapeManager>(out singlton);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			rayCastDistance_ = VoxelContentMap.VoxelSettings.interactionDistance;
		}

		public bool CheckIfShape(Vector2 position, out ShapeInstance act, out float distance)
		{
			Ray ray = cameraManager_.PlayerCamera.ScreenPointToRay(position);
			RaycastHit hitInfo;
			if (Physics.Raycast(ray, out hitInfo, rayCastDistance_))
			{
				Shape componentInParent = hitInfo.transform.GetComponentInParent<Shape>();
				if (componentInParent != null)
				{
					act = componentInParent.instance;
					distance = (cameraManager_.Transform.position - hitInfo.transform.position).magnitude;
					return true;
				}
			}
			distance = 0f;
			act = null;
			return false;
		}

		public void HandleClick(object sender, InputEventArgs args)
		{
			ShapeInstance act;
			float distance;
			if (this.InteractiveShapeClicked != null && CheckIfShape(args.pointerPosition, out act, out distance))
			{
				this.InteractiveShapeClicked(this, new ShapeEventArgs(act, args.pointerPosition));
				args.used = true;
			}
		}

		public void TriggerShapeTouch(ShapeInstance shape)
		{
			if (this.InteractiveShapeTouched != null)
			{
				ShapeEventArgs e = new ShapeEventArgs(shape);
				this.InteractiveShapeTouched(this, e);
			}
		}

		public void TriggerShapeEnter(ShapeInstance shape)
		{
			if (this.InteractiveShapeEnter != null)
			{
				ShapeEventArgs e = new ShapeEventArgs(shape);
				this.InteractiveShapeEnter(this, e);
			}
		}

		public void TriggerShapeExit(ShapeInstance shape)
		{
			if (this.InteractiveShapeExit != null)
			{
				ShapeEventArgs e = new ShapeEventArgs(shape);
				this.InteractiveShapeExit(this, e);
			}
		}
	}
}
