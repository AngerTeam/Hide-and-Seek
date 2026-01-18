using UnityEngine;

namespace HttpNetwork
{
	public class HttpWWWFormTask : HttpCommandTask
	{
		private WWWForm wwwForm_;

		public HttpWWWFormTask(string url, WWWForm wwwForm)
			: base(url, null)
		{
			url_ = url;
			wwwForm_ = wwwForm;
		}

		public override void CreateWWW()
		{
			www = new WWW(url_, wwwForm_);
		}

		public override void Dispose()
		{
		}
	}
}
