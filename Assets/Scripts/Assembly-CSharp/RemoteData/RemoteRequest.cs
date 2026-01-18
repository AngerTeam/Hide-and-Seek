using Interlace.Amf;

namespace RemoteData
{
	public class RemoteRequest
	{
		protected virtual AmfObject GetAmfObject()
		{
			return new AmfObject();
		}

		public virtual AmfObject Serialize(bool silent = false)
		{
			return null;
		}

		public virtual void Deserialize(AmfObject source)
		{
		}
	}
}
