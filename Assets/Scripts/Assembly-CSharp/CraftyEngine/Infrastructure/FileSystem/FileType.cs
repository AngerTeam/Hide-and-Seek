using System;

namespace CraftyEngine.Infrastructure.FileSystem
{
	[Flags]
	public enum FileType
	{
		Bytes = 1,
		Texture = 2,
		AmfObject = 4,
		UncompressedBundle = 8,
		Bundle = 0x10,
		Text = 0x20,
		AmfArray = 0x40,
		Audio = 0x80,
		IsBundle = 0x18
	}
}
