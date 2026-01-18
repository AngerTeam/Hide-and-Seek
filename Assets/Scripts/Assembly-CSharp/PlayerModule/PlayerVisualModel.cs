using UnityEngine;

namespace PlayerModule
{
	public class PlayerVisualModel
	{
		public Vector3 itemRotation;

		public bool attacking;

		public Animator Animator;

		public GameObject GameObject;

		public Renderer Renderer;

		public Transform SpineBone;

		public Transform Transform;

		public Transform TorsoBone;

		public Collider[] bodyColliders;

		public Material[] bodyMaterial;

		public float NicknameAnchorHeight;

		public float walkSpeed;

		public Vector3 walkDirection;

		public bool jumpPending;

		public PlayerVisualModelByCamera byCamera1St;

		public PlayerVisualModelByCamera byCamera3Rd;

		public int stepSoundId;

		public bool Statinoary
		{
			get
			{
				return Mathf.Abs(walkSpeed) < 0.05f;
			}
		}

		public PlayerVisualModel()
		{
			NicknameAnchorHeight = 2.05f;
			byCamera1St = new PlayerVisualModelByCamera();
			byCamera3Rd = new PlayerVisualModelByCamera();
		}
	}
}
