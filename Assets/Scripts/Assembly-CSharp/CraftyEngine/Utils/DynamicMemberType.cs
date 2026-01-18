namespace CraftyEngine.Utils
{
	public class DynamicMemberType : DynamicType
	{
		public string memberName;

		public override string Name
		{
			get
			{
				return memberName;
			}
		}
	}
}
