namespace Interlace.Amf.Extended
{
	public class OptAmfRegistry : AmfRegistry
	{
		public OptAmfRegistry()
		{
			OptAmfAnonymousClassDescriptor value = new OptAmfAnonymousClassDescriptor();
			_aliases[string.Empty] = value;
			_types[typeof(AmfObject)] = value;
		}
	}
}
