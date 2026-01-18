using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

public static class CommandLineArgumentsConductor
{
	public static bool excludeQuotes = true;

	private static List<string> ingnoredArgs_ = new List<string> { "-batchmode", "-nographics", "-logfile" };

	private static Regex argumentParser_ = new Regex("-(.*)=(.*)");

	private static Dictionary<string, string> args_ = new Dictionary<string, string>();

	public static Dictionary<string, string> GetArguments()
	{
		args_.Clear();
		string[] commandLineArgs = Environment.GetCommandLineArgs();
		if (commandLineArgs != null)
		{
			string[] array = commandLineArgs;
			foreach (string text in array)
			{
				try
				{
					if (!TryIgnore(text))
					{
						Match match = argumentParser_.Match(text);
						string value = match.Groups[1].Value;
						string text2 = match.Groups[2].Value;
						if (excludeQuotes && text2.StartsWith("\"") && text2.EndsWith("\""))
						{
							text2 = text2.Remove(0, 1);
							text2 = text2.Remove(text2.Length - 1, 1);
						}
						if (!string.IsNullOrEmpty(value) && !string.IsNullOrEmpty(text2))
						{
							Log.Info("Argument \"{0}\" = \"{1}\" saved", value, text2);
							args_[value] = text2;
						}
					}
				}
				catch (Exception ex)
				{
					Log.Warning("Unable to parse argument {0}: {1}", text, ex.Message);
				}
			}
		}
		return args_;
	}

	private static bool TryIgnore(string argument)
	{
		foreach (string item in ingnoredArgs_)
		{
			if (argument.StartsWith(item))
			{
				return true;
			}
		}
		return false;
	}
}
