using System.IO;
using System.Text;

namespace LogSystem
{
	public class LogTargetLoopFile : LogTargetFileBase
	{
		private const int MAX_BYTES_COUNT = 5242880;

		private const string HELLO = "Log file";

		private const string SEPARATOR = "\r\n####\r\n\r\n";

		private byte[] separatorBytes;

		private byte[] helloBytes;

		public LogTargetLoopFile(string name)
			: base(name)
		{
			separatorBytes = Encoding.UTF8.GetBytes("\r\n####\r\n\r\n");
			helloMessage = "Log file";
			helloBytes = Encoding.UTF8.GetBytes(helloMessage);
		}

		protected override void Write(string text)
		{
			if (stream.Position >= 5242880)
			{
				stream.Seek(helloBytes.Length, SeekOrigin.Begin);
			}
			else if (stream.Position >= separatorBytes.Length)
			{
				stream.Seek(-separatorBytes.Length, SeekOrigin.Current);
			}
			byte[] bytes = Encoding.UTF8.GetBytes(text + "\r\n");
			stream.Write(bytes, 0, bytes.Length);
			stream.Write(separatorBytes, 0, separatorBytes.Length);
			stream.Flush();
		}
	}
}
