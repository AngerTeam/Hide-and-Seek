namespace CraftyVoxelEngine
{
	public class ReactionType
	{
		public const int UNKNOWN_ACTION = 2000;

		public const int VOXEL_DATA_READY = 2001;

		public const int MAP_DATA_READY = 2002;

		public const int GET_VOXEL_RESULT = 2003;

		public const int RAY_CAST_RESULT = 2004;

		public const int HIT_CAST_RESULT = 2005;

		public const int KEY_OUT_OF_MAP = 2006;

		public const int VOXEL_CHANGED = 2007;

		public const int CHUNK_RENDERED = 2008;

		public const int CHUNK_HIDDEN = 2009;

		public const int CHUNK_SHOWED = 2010;

		public const int CHUNK_DISPOSED = 2011;

		public const int UNKNOWN_COLUMN_STATE = 2012;

		public const int INTERACTIVE_VOXEL_CHANGED = 2013;

		public const int VOXEL_RENDERED = 2014;

		public const int OUT_OF_TASKS = 2015;

		public const int OUT_OF_RENDERING_TASKS = 2016;

		public const int REACTION_CHUNK_STATUS = 2017;

		public static string ToString(int value)
		{
			switch (value)
			{
			case 2000:
				return "UNKNOWN_ACTION";
			case 2001:
				return "VOXEL_DATA_READY";
			case 2002:
				return "MAP_DATA_READY";
			case 2003:
				return "GET_VOXEL_RESULT";
			case 2004:
				return "RAY_CAST_RESULT";
			case 2005:
				return "HIT_CAST_RESULT";
			case 2006:
				return "KEY_OUT_OF_MAP";
			case 2007:
				return "VOXEL_CHANGED";
			case 2008:
				return "CHUNK_RENDERED";
			case 2009:
				return "CHUNK_HIDDEN";
			case 2010:
				return "CHUNK_SHOWED";
			case 2011:
				return "CHUNK_DISPOSED";
			case 2012:
				return "UNKNOWN_COLUMN_STATE";
			case 2013:
				return "INTERACTIVE_VOXEL_CHANGED";
			case 2014:
				return "REACTION_VOXEL_RENDERED";
			case 2015:
				return "OUT_OF_TASKS";
			case 2016:
				return "OUT_OF_RENDERING_TASKS";
			case 2017:
				return "REACTION_CHUNK_STATUS";
			default:
				return "Unknown reaction type " + value;
			}
		}

		internal static bool Silent(int id)
		{
			if (id == 2016)
			{
				return false;
			}
			return true;
		}
	}
}
