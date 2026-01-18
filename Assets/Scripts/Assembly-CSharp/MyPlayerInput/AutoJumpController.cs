using CraftyVoxelEngine;
using UnityEngine;

namespace MyPlayerInput
{
	public class AutoJumpController
	{
		public bool enabled = true;

		private float resetDuration = 2.5f;

		private float delay = 0.35f;

		private bool started;

		private bool pending;

		private float lastTime;

		private float pendingStartTime;

		public AutoJumpController(float delay, float resetDuration)
		{
			this.resetDuration = resetDuration;
			this.delay = delay;
		}

		internal void Update(Vector2 input)
		{
			if (pending && Time.unscaledTime - pendingStartTime > delay)
			{
				pending = false;
				started = true;
				lastTime = 0f;
			}
			if (started && lastTime > 0f && Time.unscaledTime - lastTime > resetDuration)
			{
				pending = false;
				started = false;
			}
			if (input == Vector2.zero)
			{
				started = false;
			}
		}

		internal bool HandleInput(Vector3 checkPositionBottom, Vector3 checkPositionTop, VoxelRigidBody rigidBody)
		{
			if (enabled)
			{
				checkPositionBottom = checkPositionBottom.MoveY(0.1f);
				bool flag = rigidBody.CheckCollision(checkPositionBottom);
				bool flag2 = rigidBody.CheckCollision(checkPositionTop);
				if (flag && !flag2)
				{
					if (started)
					{
						lastTime = Time.unscaledTime;
						return true;
					}
					if (!pending)
					{
						SetAutoJumpPending();
					}
				}
			}
			return false;
		}

		private void SetAutoJumpPending()
		{
			pending = true;
			pendingStartTime = Time.unscaledTime;
		}
	}
}
