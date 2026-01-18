using System.Collections.Generic;
using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class VoxelContentMap : ContentMapBase
	{
		public static VoxelSettingsEntries VoxelSettings;

		public static Dictionary<int, DurabilityTypesEntries> DurabilityTypes;

		public static Dictionary<int, LogicVoxelsEntries> LogicVoxels;

		public static Dictionary<int, TexturesEntries> Textures;

		public static Dictionary<int, VoxelsEntries> Voxels;

		public static Dictionary<int, VoxelLogicSettingsEntries> VoxelLogicSettings;

		public static Dictionary<int, VoxelModelsEntries> VoxelModels;

		public static Dictionary<int, VoxelOptionsEntries> VoxelOptions;

		public static Dictionary<int, VoxelTexturesEntries> VoxelTextures;

		public override void Deserialize()
		{
			VoxelContentKeys.Deserialize();
			VoxelSettings = FillSettings<VoxelSettingsEntries>("settings");
			DurabilityTypes = ReadInt<DurabilityTypesEntries>(VoxelContentKeys.durability_types);
			LogicVoxels = ReadInt<LogicVoxelsEntries>(VoxelContentKeys.logic_voxels);
			Textures = ReadInt<TexturesEntries>(VoxelContentKeys.textures);
			Voxels = ReadInt<VoxelsEntries>(VoxelContentKeys.voxels);
			VoxelLogicSettings = ReadInt<VoxelLogicSettingsEntries>(VoxelContentKeys.voxel_logic_settings);
			VoxelModels = ReadInt<VoxelModelsEntries>(VoxelContentKeys.voxel_models);
			VoxelOptions = ReadInt<VoxelOptionsEntries>(VoxelContentKeys.voxel_options);
			VoxelTextures = ReadInt<VoxelTexturesEntries>(VoxelContentKeys.voxel_textures);
			base.Deserialize();
		}
	}
}
