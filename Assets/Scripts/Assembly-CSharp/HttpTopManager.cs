using Authorization;
using CraftyNetworkEngine;
using GameInfrastructure;
using HttpNetwork;
using InventoryOnlineModule;
using PlayerModule.MyPlayer;

public class HttpTopManager : Singleton
{
	private AuthorizationEntity authorizationEntity_;

	private AuthorizationModel authorizationModel_;

	private MyPlayerStatsModel myPlayerStatsModel_;

	public bool enableAutoAuthorizate;

	public static void InitAuth(int layer)
	{
		AuthorizationModel authorizationModel = SingletonManager.Add<AuthorizationModel>(layer);
		authorizationModel.isInstalledFromStore = VersionUtil.InstalledFromStore();
		SingletonManager.Add<AuthorizationEntity>(layer);
		SingletonManager.Add<PvpAuthorizationModel>(layer);
		SingletonManager.Add<HttpTopManager>(layer);
	}

	public static void InitModule(int layer)
	{
		SingletonManager.AddAlias<HttpInventoryOnline, IInventoryOnline>(layer);
		SingletonManager.Add<NetworkInventoryManager>(layer);
		SingletonManager.AddAlias<HttpShopOnline, IShopOnline>(layer);
	}

	public override void OnDataLoaded()
	{
		if (enableAutoAuthorizate)
		{
			Authorizate();
		}
	}

	public void Authorizate()
	{
		if (!authorizationModel_.started && !authorizationModel_.HasSession)
		{
			authorizationEntity_.Succeed += HandleAuthorizationSucceed;
			authorizationEntity_.Login();
		}
	}

	public void Sync()
	{
		authorizationEntity_.Sync();
	}

	public override void Dispose()
	{
		if (authorizationEntity_ != null)
		{
			authorizationEntity_.Succeed -= HandleAuthorizationSucceed;
		}
		authorizationModel_.result = AuthorisationResult.Undefined;
	}

	public override void Init()
	{
		SingletonManager.Get<AuthorizationEntity>(out authorizationEntity_);
		SingletonManager.Get<AuthorizationModel>(out authorizationModel_);
		SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
	}

	private void HandleAuthorizationSucceed()
	{
		HttpOnlineModel httpOnlineModel = SingletonManager.Get<HttpOnlineModel>();
		myPlayerStatsModel_.stats.persId = httpOnlineModel.persId;
		authorizationModel_.result = ((!authorizationModel_.alreadyInPvp) ? AuthorisationResult.Normal : AuthorisationResult.RestoreSession);
	}
}
