using System;

[Serializable]
public class MessageFieldData
{
	public string name;

	public string type;

	public bool array;

	public int length;

	public string[] union;

	public bool isFixed
	{
		get
		{
			return length > 0;
		}
	}
}
