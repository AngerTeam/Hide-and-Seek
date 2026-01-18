using System;
using System.Collections.Generic;
using System.IO;
using CraftyEngine;
using UnityEngine;

namespace LogSystem
{
	public abstract class LogTargetFileBase : Log.LogTarget
	{
		private const string LOG_FILE_ARGUMENT = "log_file";

		private const string LOG_LEVEL_ARGUMENT = "log_level";

		protected FileStream stream;

		protected string helloMessage;

		private int logLevel;

		private ThreadDataTransfer<Message> transfer_;

		private bool locked_;

		public string FilePath { get; protected set; }

		protected LogTargetFileBase(string name)
		{
			if (!CompileConstants.MOBILE)
			{
				SetCommandLineArgsForLogging();
			}
			logLevel = DataStorage.logLevel;
			string text = Path.Combine((!(CompileConstants.PLATFORM == "LINUX")) ? Application.persistentDataPath : Application.dataPath.Replace("Assets", string.Empty), "Logs");
			if (!Directory.Exists(text))
			{
				Directory.CreateDirectory(text);
			}
			List<string> list = new List<string>(Directory.GetFiles(text));
			if (list.Count > 10)
			{
				list.Sort((string a, string b) => string.Compare(a, b, StringComparison.Ordinal));
			}
			for (int i = 0; i < list.Count - 10; i++)
			{
				try
				{
					File.Delete(list[i]);
				}
				catch (Exception exc)
				{
					Log.Exception(exc);
				}
			}
			FilePath = string.Format("{0}_{1:yyyyMMddHHmmss}.txt", name, DateTime.Now);
			FilePath = Path.Combine(text, FilePath);
			transfer_ = new CraftyThreadDataTransfer<Message>(false, true);
			transfer_.Process += Process;
		}

		public override void AddMessage(Log.LogCategory category, string message)
		{
			if (logLevel <= (int)category)
			{
				transfer_.Enqueue(new Message
				{
					category = category,
					message = message
				});
			}
		}

		public void Flush()
		{
			stream.Close();
			stream = null;
		}

		protected abstract void Write(string text);

		private static void SetCommandLineArgsForLogging()
		{
			Dictionary<string, string> arguments = CommandLineArgumentsConductor.GetArguments();
			if (arguments.ContainsKey("log_file"))
			{
				DataStorage.logFile = arguments["log_file"];
			}
			int result;
			if (arguments.ContainsKey("log_level") && int.TryParse(arguments["log_level"], out result))
			{
				DataStorage.logLevel = result;
			}
		}

		private void Process(Message obj)
		{
			string text = string.Format("{2:HH:mm:ss} {0}: {1}", obj.category, obj.message, DateTime.Now);
			if (stream == null)
			{
				stream = new FileStream(FilePath, FileMode.OpenOrCreate);
				if (!string.IsNullOrEmpty(helloMessage))
				{
					Write(helloMessage);
				}
			}
			if (!locked_)
			{
				Write(text);
			}
		}

		public void Lock(bool enable)
		{
			transfer_.holdProcess = enable;
			locked_ = enable;
		}
	}
}
