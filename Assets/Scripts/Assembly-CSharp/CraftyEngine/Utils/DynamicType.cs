using System;

namespace CraftyEngine.Utils
{
	public abstract class DynamicType : IEquatable<DynamicType>
	{
		public AccessibilityFlags flags;

		public bool nullable;

		public string typeName;

		public string comment;

		public string[] attributes;

		public abstract string Name { get; }

		public bool Equals(DynamicType other)
		{
			return Name == other.Name;
		}
	}
}
