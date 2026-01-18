using System.Collections.Generic;
using CraftyEngine.Content;

namespace BankModule
{
	public class BankContentMap : ContentMapBase
	{
		public static Dictionary<int, InappsEntries> Inapps;

		public override void Deserialize()
		{
			BankContentKeys.Deserialize();
			Inapps = ReadInt<InappsEntries>(BankContentKeys.inapps);
			base.Deserialize();
		}
	}
}
