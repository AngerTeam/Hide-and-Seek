using UnityEngine;

namespace WebViewModule
{
	public class WebViewHandler : Singleton
	{
		public void OpenURL(string url)
		{
			if (CompileConstants.EDITOR || !CompileConstants.IOS)
			{
				Application.OpenURL(url);
			}
		}
	}
}
