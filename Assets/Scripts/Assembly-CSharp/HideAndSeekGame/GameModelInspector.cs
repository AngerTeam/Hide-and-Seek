using CraftyEngine.States;
using UnityEngine;

namespace HideAndSeekGame
{
	public class GameModelInspector : MonoBehaviour, IModelInspector
	{
		public GameModel model;

		public object Model
		{
			set
			{
				model = (GameModel)value;
			}
		}
	}
}
