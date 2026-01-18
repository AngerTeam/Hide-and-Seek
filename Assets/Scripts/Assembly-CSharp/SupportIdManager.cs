public class SupportIdManager : PermanentSingleton
{
	public string SupportId { get; private set; }

	public override void Init()
	{
		SupportId = GetSupportId();
	}

	public void SetSupportId(string supportId)
	{
		SupportId = supportId;
		PlayerSupportId playerSupportId = new PlayerSupportId();
		playerSupportId.supportId = supportId;
		PersistanceManager.Save(playerSupportId);
	}

	private string GetSupportId()
	{
		PlayerSupportId settings;
		PersistanceManager.Get<PlayerSupportId>(out settings);
		if (settings != null && !string.IsNullOrEmpty(settings.supportId))
		{
			return settings.supportId;
		}
		return string.Empty;
	}
}
