using System.Collections.Generic;

namespace CraftyEngine.Content
{
	public class CraftyEngineContentMap : ContentMapBase
	{
		public static Dictionary<int, ExceptionsEntries> Exceptions;

		public override void Deserialize()
		{
			CraftyEngineContentKeys.Deserialize();
			Exceptions = ReadInt<ExceptionsEntries>(CraftyEngineContentKeys.exceptions);
			base.Deserialize();
		}
	}
}
