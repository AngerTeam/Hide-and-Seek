namespace CraftyEngine.Utils
{
	public class DynamicMethodType : DynamicMemberType
	{
		public string[] args;

		public string body;

		public bool isConstructor;

		public bool isDestructor;

		public bool h;

		public string returnType;

		public string[] base_args;

		public DynamicMethodType(string methodName)
		{
			memberName = methodName;
		}
	}
}
