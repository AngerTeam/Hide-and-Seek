public class PvpSide
{
	public const int NO_SIDE = 0;

	public const int BLUE_TEAM = 1;

	public const int RED_TEAM = 2;

	public const int HIDERS = 3;

	public const int SEEKERS = 4;

	public const int WAITERS = 5;

	public static int ConvertSideToServerFormat(int side)
	{
		if (side == 5)
		{
			return 0;
		}
		return side;
	}
}
