using System.Collections.Generic;
using CraftyEngine.Infrastructure.SingletonManagerCore;
using UnityEngine;

public class TutorialStorage
{
	public static List<TutorialGameObject> list;

	private static bool inited_;

	public static TutorialGameObject Register(GameObject gameObject, int ID, int x = 0, int y = 0)
	{
		if (!inited_)
		{
			Init();
		}
		TutorialGameObject tutorialGameObject = new TutorialGameObject();
		tutorialGameObject.ID = ID;
		tutorialGameObject.x = x;
		tutorialGameObject.y = y;
		tutorialGameObject.gameObject = gameObject;
		TutorialGameObject tutorialGameObject2 = tutorialGameObject;
		list.Add(tutorialGameObject2);
		return tutorialGameObject2;
	}

	private static void Init()
	{
		list = new List<TutorialGameObject>();
		SingletonManager.PhaseCompleted += HandleSingletonPhase;
		inited_ = true;
	}

	private static void HandleSingletonPhase(SingletonPhase phase, int layer)
	{
		if (phase == SingletonPhase.Reset)
		{
			list.Clear();
		}
	}
}
