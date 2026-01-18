using CraftyEngine.Content;

namespace InventoryModule
{
	public class InventoryModuleContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<InventoryContentMap>();
			InventoryContentMap.CraftSettings.handArtikul = InventoryContentMap.Artikuls[InventoryContentMap.CraftSettings.handArtikulId];
			InventoryContentMap.CraftSettings.handArtikul.isHand = true;
			foreach (ArtikulsEntries value2 in InventoryContentMap.Artikuls.Values)
			{
				WeaponTypesEntries value;
				if (InventoryContentMap.WeaponTypes.TryGetValue(value2.weapon_type, out value))
				{
					value2.weaponType = InventoryContentMap.WeaponTypes[value2.weapon_type];
					value2.ranged = value2.weaponType.melee == 0;
				}
			}
		}
	}
}
