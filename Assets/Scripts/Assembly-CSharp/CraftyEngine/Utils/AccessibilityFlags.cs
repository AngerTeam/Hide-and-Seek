using System;

namespace CraftyEngine.Utils
{
	[Flags]
	public enum AccessibilityFlags
	{
		Undefined = 1,
		Override = 2,
		Abstract = 4,
		Virtual = 8,
		Readonly = 0x10,
		Private = 0x20,
		Public = 0x40,
		Protected = 0x80,
		Static = 0x100,
		Partial = 0x200,
		Const = 0x400,
		Event = 0x800,
		Empty = 0x1000
	}
}
