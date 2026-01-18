using CraftyEngine.States;

namespace HideAndSeekGame
{
	public class GameState : State
	{
		public int hudState;

		public GameStateType type;

		public GameState(string name, GameStateType type = GameStateType.Undefined)
			: base(name)
		{
			hudState = -1;
			this.type = type;
		}

		public GameState(string name, int hudState, GameStateType type = GameStateType.Undefined)
			: base(name)
		{
			this.hudState = hudState;
			this.type = type;
		}
	}
}
