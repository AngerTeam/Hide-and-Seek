using Interlace.Amf;

namespace RemoteData.Lua
{
	public class BindPlayerMessage : RemoteMessage
	{
		public int userId;

		public string persId;

		public string gameCenterId;

		public string name;

		public int level;

		public int money;

		public string email;

		public string passwd;

		public BindPlayerMessage(int userId, string persId, string gameCenterId, string name, int level, int money, string email, string passwd)
		{
			this.userId = userId;
			this.persId = persId;
			this.gameCenterId = gameCenterId;
			this.name = name;
			this.level = level;
			this.money = money;
			this.email = email;
			this.passwd = passwd;
		}

		public BindPlayerMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			userId = Get<int>(source, "user_id", false);
			persId = Get<string>(source, "pers_id", false);
			gameCenterId = Get<string>(source, "game_center_id", false);
			name = Get<string>(source, "name", false);
			level = Get<int>(source, "level", false);
			money = Get<int>(source, "money", false);
			email = Get<string>(source, "email", false);
			passwd = Get<string>(source, "passwd", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("BindPlayerMessage: userId: {0}; persId: {1}; gameCenterId: {2}; name: {3}; level: {4}; money: {5}; email: {6}; passwd: {7};", userId, persId, gameCenterId, name, level, money, email, "***");
		}
	}
}
