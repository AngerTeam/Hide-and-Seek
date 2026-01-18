namespace Interlace.Amf.Extended
{
	public class AmfDisposer
	{
		public static void Dispose(object val)
		{
			OptAmfArray optAmfArray = val as OptAmfArray;
			if (optAmfArray != null)
			{
				optAmfArray.Dispose();
			}
			OptAmfObject optAmfObject = val as OptAmfObject;
			if (optAmfObject != null)
			{
				optAmfObject.Dispose();
			}
		}
	}
}
