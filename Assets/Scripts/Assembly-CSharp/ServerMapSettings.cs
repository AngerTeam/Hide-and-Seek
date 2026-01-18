using System;

[Serializable]
public class ServerMapSettings
{
	public int mode_id;

	public int players_limit;

	public int critical_height;

	public int flags;

	public int ttl;

	public int idle_timeout;

	public int hide_timeout;

	public int seek_timeout;

	public int hide_fight_timeout;

	public int hide_players_limit;

	public ServerSpawnSettings[] spawn_points;

	public ServerSkinSettings[] skins;

	public ServerMapSettings(int mode = 0)
	{
		mode_id = mode;
	}
}
