using Authorization;

namespace HttpNetwork
{
	public class ServerOnlineControllerBase
	{
		protected AuthorizationModel authModel;

		protected HttpOnlineModel httpModel;

		protected HttpOnlineManager http;

		public ServerOnlineControllerBase()
		{
			SingletonManager.Get<AuthorizationModel>(out authModel);
			SingletonManager.Get<HttpOnlineModel>(out httpModel);
			SingletonManager.Get<HttpOnlineManager>(out http);
		}
	}
}
