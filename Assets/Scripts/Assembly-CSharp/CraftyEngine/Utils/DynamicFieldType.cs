namespace CraftyEngine.Utils
{
	public class DynamicFieldType : DynamicMemberType
	{
		public string defaultValue;

		public string[] union;

		public DynamicFieldType(string name, string typeName)
		{
			memberName = name;
			base.typeName = typeName;
		}
	}
}
