using CraftyEngine.Infrastructure.SingletonManagerCore;
using UnityEngine;

namespace HideAndSeekGame
{
	public class Executer : MonoBehaviour
	{
		public bool async;

		public bool step;

		public int stepsCount = 1000;

		[HideInInspector]
		public int currentStep;

		private void Update()
		{
			if (step)
			{
				SingletonAsyncPass.Update();
				currentStep++;
				if (currentStep >= stepsCount)
				{
					currentStep = 0;
					step = false;
				}
			}
		}

		private void Start()
		{
			SingletonAsyncPass.async = async;
			GameEntity.Instantiate();
			GameModel singlton;
			SingletonManager.Get<GameModel>(out singlton);
			singlton.lobby = true;
		}
	}
}
