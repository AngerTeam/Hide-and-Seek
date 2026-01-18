using CraftyEngine.States;
using UnityEngine;

namespace Authorization
{
	public class AuthModelInspector : MonoBehaviour, IModelInspector
	{
		public AuthorizationModel model;

		public object Model
		{
			set
			{
				model = (AuthorizationModel)value;
			}
		}
	}
}
