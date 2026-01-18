using System;

namespace CraftyEngine.Content
{
	[Serializable]
	public class ContentVersionInfo
	{
		public ContentPlatformInfo[] builds;

		public ContentBundleInfo[] bundle_builds;

		public string deploy;
	}
}
