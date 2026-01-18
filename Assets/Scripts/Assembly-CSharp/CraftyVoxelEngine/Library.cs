using System.Runtime.InteropServices;
using System.Text;

namespace CraftyVoxelEngine
{
	public class Library
	{
		public const string Name = "VoxelCore";

		public const int LOG_LEVEL_NULL = 0;

		public const int LOG_LEVEL_ERROR = 1;

		public const int LOG_LEVEL_WARNING = 2;

		public const int LOG_LEVEL_INFO = 3;

		public const int LOG_LEVEL_TEMP = 4;

		public const int LOG_LEVEL_ALL = 5;

		private static string version_;

		public static string Version
		{
			get
			{
				if (version_ == null)
				{
					byte[] data = LibraryVersion();
					version_ = str(data);
				}
				return version_;
			}
		}

		private Library()
		{
		}

		[DllImport("VoxelCore")]
		private static extern byte[] LibraryVersion();

		[DllImport("VoxelCore")]
		public static extern void GetLibraryVersion(out int major, out int minor, out int build);

		[DllImport("VoxelCore")]
		private static extern void SetLogPath(byte[] path, int length);

		[DllImport("VoxelCore")]
		public static extern void SetLogLevel(int level);

		private static string str(byte[] data)
		{
			string @string = Encoding.UTF8.GetString(data);
			return @string.Replace("\0", string.Empty);
		}

		public static void SetLogPath(string path)
		{
			byte[] bytes = Encoding.ASCII.GetBytes(path);
			SetLogPath(bytes, bytes.Length);
		}
	}
}
