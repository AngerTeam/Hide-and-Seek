using System.Collections.Generic;
using System.IO;
using CraftyEngine.States;
using UnityEngine;

namespace ExceptionsModule
{
	public class ExceptionsStatistics : Singleton
	{
		public static string hostingUrl = "http://deploy.hidenseek.online/public/";

		private static readonly string relativePath = "crash_report.php";

		public WWW Report(ExceptionArgs args, string exception)
		{
			string allStateMachinesList = StateMachine.GetAllStateMachinesList();
			WWWForm form = ContentStandart.GetForm(CompileConstants.PLATFORM);
			if (LogReporterModel.info != null)
			{
				foreach (KeyValuePair<string, string> item in LogReporterModel.info)
				{
					form.AddField(item.Key, item.Value);
				}
			}
			form.AddField("pf", CompileConstants.PLATFORM);
			form.AddField("locale", (Application.systemLanguage != SystemLanguage.Russian) ? "en_US" : "ru_RU");
			form.AddField("version", string.Format("v{0} ({1})", DataStorage.releaseVersion, DataStorage.version.Replace(".", string.Empty)));
			form.AddField("error", exception);
			form.AddField("log", allStateMachinesList);
			form.AddField("exception_id", args.Id);
			string url = Path.Combine(hostingUrl, relativePath);
			return new WWW(url, form);
		}
	}
}
