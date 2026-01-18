using System;
using Authorization;
using CraftyEngine.States;
using Extensions;
using GameInfrastructure;
using HttpNetwork;

namespace PrimeModule
{
	public class ReenterPrimeController
	{
		private GameModel model_;

		private AuthorizationModel authorizationModel_;

		public event Action<int> MapIdRecieved;

		public ReenterPrimeController(State desidion, State prime)
		{
			State state = new State("loadLastMapData");
			state.Entered += LoadLastMapData;
			desidion.AddTransaction(state, () => authorizationModel_.result == AuthorisationResult.RestoreSession);
			state.AddTransaction(prime, () => authorizationModel_.result == AuthorisationResult.Normal);
		}

		public void Init()
		{
			SingletonManager.Get<GameModel>(out model_);
			SingletonManager.Get<AuthorizationModel>(out authorizationModel_);
		}

		public void Continue()
		{
			authorizationModel_.result = AuthorisationResult.Normal;
		}

		private void LoadLastMapData()
		{
			model_.lobby = false;
			model_.prime = true;
			PvpAuthorizationModel pvpAuthorizationModel = SingletonManager.Get<PvpAuthorizationModel>();
			this.MapIdRecieved.SafeInvoke(pvpAuthorizationModel.mapId);
		}
	}
}
