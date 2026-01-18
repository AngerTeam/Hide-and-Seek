namespace CraftyVoxelEngine
{
	public class MessagesTypes
	{
		public const int MESSAGE_UNKNOWN_MESSAGE = 5001;

		public const int MESSAGE_SET_VOXEL = 5002;

		public const int MESSAGE_SET_VIEW_POSITION = 5003;

		public const int MESSAGE_SET_VIEW_DISTANCE = 5004;

		public const int MESSAGE_START_RENDER = 5005;

		public const int MESSAGE_RENDER_VOXEL = 5006;

		public const int MESSAGE_VOXEL_RENDERED = 5007;

		public const int MESSAGE_RESET_ALL = 5008;

		public const int MESSAGE_VOXEL_DATA_READY = 5009;

		public const int MESSAGE_FILE_DATA_READY = 5010;

		public const int MESSAGE_VOXEL_CHANGED = 5011;

		public const int MESSAGE_INTERACTIVE_VOXEL_CHANGED = 5012;

		public const int MESSAGE_KEY_OUT_OF_MAP = 5013;

		public const int MESSAGE_CHUNK_CHANGED = 5014;

		public const int MESSAGE_OUT_OF_TASKS = 5015;

		public const int MESSAGE_OUT_OF_RENDERING_TASKS = 5016;

		public const int MESSAGE_END_OF_THREAD = 5017;

		public const int MESSAGE_RE_RENDER_ALL = 5018;

		public const int MESSAGE_RESET_VOXEL_DIFFS = 5019;

		public const int MESSAGE_SAVE_MAP_TO_FILE = 5020;

		public const int MESSAGE_MAP_SAVED = 5021;

		public const int MESSAGE_LOGIC_VOXEL_CHANGED = 5022;

		public string ToString(int value)
		{
			switch (value)
			{
			case 5001:
				return "MESSAGE_UNKNOWN_MESSAGE";
			case 5002:
				return "MESSAGE_SET_VOXEL";
			case 5003:
				return "MESSAGE_SET_VIEW_POSITION";
			case 5004:
				return "MESSAGE_SET_VIEW_DISTANCE";
			case 5005:
				return "MESSAGE_START_RENDER";
			case 5006:
				return "MESSAGE_RENDER_VOXEL";
			case 5007:
				return "MESSAGE_VOXEL_RENDERED";
			case 5008:
				return "MESSAGE_RESET_ALL";
			case 5009:
				return "MESSAGE_VOXEL_DATA_READY";
			case 5010:
				return "MESSAGE_FILE_DATA_READY";
			case 5011:
				return "MESSAGE_VOXEL_CHANGED";
			case 5012:
				return "MESSAGE_INTERACTIVE_VOXEL_CHANGED";
			case 5013:
				return "MESSAGE_KEY_OUT_OF_MAP";
			case 5014:
				return "MESSAGE_CHUNK_CHANGED";
			case 5015:
				return "MESSAGE_OUT_OF_TASKS";
			case 5016:
				return "MESSAGE_OUT_OF_RENDERING_TASKS";
			case 5017:
				return "MESSAGE_END_OF_THREAD";
			case 5018:
				return "MESSAGE_RE_RENDER_ALL";
			case 5019:
				return "MESSAGE_RESET_VOXEL_DIFFS";
			case 5020:
				return "MESSAGE_SAVE_MAP_TO_FILE";
			case 5021:
				return "MESSAGE_MAP_SAVED";
			case 5022:
				return "MESSAGE_LOGIC_VOXEL_CHANGED";
			default:
				return "Unknown reaction type " + value;
			}
		}
	}
}
