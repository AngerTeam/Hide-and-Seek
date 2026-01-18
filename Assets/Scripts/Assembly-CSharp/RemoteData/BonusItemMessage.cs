using Interlace.Amf;

namespace RemoteData
{
	public class BonusItemMessage : RemoteMessage
	{
		public string typeId;

		public string field;

		public int value;

		public int value2;

		public BonusItemMessage(string typeId, string field, int value, int value2)
		{
			this.typeId = typeId;
			this.field = field;
			this.value = value;
			this.value2 = value2;
		}

		public BonusItemMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			typeId = Get<string>(source, "type_id", false);
			field = Get<string>(source, "field", false);
			value = Get<int>(source, "value", false);
			value2 = Get<int>(source, "value2", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("BonusItemMessage: typeId: {0}; field: {1}; value: {2}; value2: {3};", typeId, field, value, value2);
		}
	}
}
