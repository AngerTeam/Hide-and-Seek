using System.IO;
using System.Text;

namespace LogSystem
{
	public class LogTargetFile : LogTargetFileBase
	{
		public LogTargetFile(string name)
			: base(name)
		{
			File.WriteAllText(base.FilePath, "log file created\n", Encoding.UTF8);
		}

		protected override void Write(string text)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(text + "\r\n");
			stream.Write(bytes, 0, bytes.Length);
		}
	}
}
