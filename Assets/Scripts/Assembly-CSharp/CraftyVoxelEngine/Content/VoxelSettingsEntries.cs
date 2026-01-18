using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class VoxelSettingsEntries : ContentItem
	{
		public float interactionDistance = 5f;

		public float AOPower = 0.27f;

		public float cloudsHeight = 250f;

		public float dayLength = 864000f;

		public int dayShift = 216000;

		public float DeathHeight;

		public int dirtVoxelId = 2;

		public int errorBlock = 12;

		public int errorTexture = 7;

		public string materialAmbientColor = "000000";

		public float materialNormalPower = 0.45f;

		public string materialSkyColor = "FFEFD000";

		public int resourceType = 1;

		public int tileSize = 32;

		public float memoryRangeMax = 4096f;

		public float memoryRangeMin = 512f;

		public float viewRangeMax = 300f;

		public float viewRangeMin = 60f;

		public string LogicRegionSize = "2;1;2";

		public float editorDigCooldown = 0.5f;

		public override void Deserialize()
		{
			interactionDistance = TryGetFloat(VoxelContentKeys.interactionDistance, 5f);
			AOPower = TryGetFloat(VoxelContentKeys.AOPower, 0.27f);
			cloudsHeight = TryGetFloat(VoxelContentKeys.cloudsHeight, 250f);
			dayLength = TryGetFloat(VoxelContentKeys.dayLength, 864000f);
			dayShift = TryGetInt(VoxelContentKeys.dayShift, 216000);
			DeathHeight = TryGetFloat(VoxelContentKeys.DeathHeight);
			dirtVoxelId = TryGetInt(VoxelContentKeys.dirtVoxelId, 2);
			errorBlock = TryGetInt(VoxelContentKeys.errorBlock, 12);
			errorTexture = TryGetInt(VoxelContentKeys.errorTexture, 7);
			materialAmbientColor = TryGetString(VoxelContentKeys.materialAmbientColor, "000000");
			materialNormalPower = TryGetFloat(VoxelContentKeys.materialNormalPower, 0.45f);
			materialSkyColor = TryGetString(VoxelContentKeys.materialSkyColor, "FFEFD000");
			resourceType = TryGetInt(VoxelContentKeys.resourceType, 1);
			tileSize = TryGetInt(VoxelContentKeys.tileSize, 32);
			memoryRangeMax = TryGetFloat(VoxelContentKeys.memoryRangeMax, 4096f);
			memoryRangeMin = TryGetFloat(VoxelContentKeys.memoryRangeMin, 512f);
			viewRangeMax = TryGetFloat(VoxelContentKeys.viewRangeMax, 300f);
			viewRangeMin = TryGetFloat(VoxelContentKeys.viewRangeMin, 60f);
			LogicRegionSize = TryGetString(VoxelContentKeys.LogicRegionSize, "2;1;2");
			editorDigCooldown = TryGetFloat(VoxelContentKeys.editorDigCooldown, 0.5f);
			base.Deserialize();
		}
	}
}
