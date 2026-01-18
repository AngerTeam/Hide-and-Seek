using Interlace.Amf;

namespace RemoteData.Socket
{
	public class MaintenanceCheckResponse : RemoteMessage
	{
		public int maintenance;

		public MaintenanceCheckResponse(int maintenance)
		{
			this.maintenance = maintenance;
		}

		public MaintenanceCheckResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			maintenance = Get<int>(source, "maintenance", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("MaintenanceCheckResponse: maintenance: {0};", maintenance);
		}
	}
}
