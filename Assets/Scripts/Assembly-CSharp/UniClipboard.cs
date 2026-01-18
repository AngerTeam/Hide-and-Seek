using UnityEngine;

public class UniClipboard
{
	private static IBoard _board;

	private static IBoard board
	{
		get
		{
			if (_board == null)
			{
				_board = new AndroidBoard();
			}
			return _board;
		}
	}

	public static void SetText(string str)
	{
		Debug.Log("SetText: " + str);
		board.SetText(str);
	}

	public static string GetText()
	{
		return board.GetText();
	}
}
