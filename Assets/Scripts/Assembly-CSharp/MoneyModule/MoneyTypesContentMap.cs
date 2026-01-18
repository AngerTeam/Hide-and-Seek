using System.Collections.Generic;
using CraftyEngine.Content;

namespace MoneyModule
{
	public class MoneyTypesContentMap : ContentMapBase
	{
		public static Dictionary<int, MoneyTypesEntries> MoneyTypes;

		public override void Deserialize()
		{
			MoneyTypesContentKeys.Deserialize();
			MoneyTypes = ReadInt<MoneyTypesEntries>(MoneyTypesContentKeys.money_types);
			base.Deserialize();
		}
	}
}
