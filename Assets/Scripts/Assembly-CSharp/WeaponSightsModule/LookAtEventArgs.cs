namespace WeaponSightsModule
{
	public struct LookAtEventArgs
	{
		public LookingAt LookingAt;

		public LookAtEventArgs(LookingAt lookingAt)
		{
			LookingAt = lookingAt;
		}
	}
}
