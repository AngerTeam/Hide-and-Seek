using CraftyEngine.States;
using UnityEngine;

namespace PrimeModule
{
	public class PrimeGameStateModelInspector : MonoBehaviour, IModelInspector
	{
		public PrimeConnectModel model;

		public object Model
		{
			set
			{
				model = (PrimeConnectModel)value;
			}
		}
	}
}
