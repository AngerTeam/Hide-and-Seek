using CraftyEngine.Content;

namespace ExceptionsModule
{
	public class ExceptionArgs
	{
		public ExceptionsEntries exceptionEntry;

		public object context;

		public object data;

		public bool debug;

		public int count;

		public int Id { get; private set; }

		public ExceptionArgs(int id, ExceptionsEntries exceptionEntry = null, object context = null, object data = null, bool debug = false)
		{
			Id = id;
			this.exceptionEntry = exceptionEntry;
			this.context = context;
			this.data = data;
			this.debug = debug;
		}
	}
}
