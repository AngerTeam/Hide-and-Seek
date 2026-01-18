using DG.Tweening;
using UnityEngine;

namespace PopUpModule
{
	public class Message
	{
		public bool dead;

		public bool dies;

		public UILabel message;

		public Transform trans;

		public Sequence sequence;

		public Tween stepTween;

		public int targetStep;
	}
}
