using CraftyEngine.States;
using UnityEngine;

public class DailyBonusModelInspector : MonoBehaviour, IModelInspector
{
	public DailyBonusModel model;

	public object Model
	{
		set
		{
			model = (DailyBonusModel)value;
		}
	}
}
