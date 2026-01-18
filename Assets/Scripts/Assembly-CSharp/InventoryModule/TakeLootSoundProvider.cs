using System.Timers;
using CraftyEngine.Sounds;

namespace InventoryModule
{
	public class TakeLootSoundProvider
	{
		private static float time_ = 0.1f;

		private static Timer timer_;

		public static bool lockSound { get; private set; }

		public static void PlayTakeLootSound()
		{
			if (!lockSound)
			{
				lockSound = true;
				if (timer_ == null)
				{
					timer_ = new Timer(time_ * 1000f);
					timer_.AutoReset = false;
					timer_.Elapsed += OnComplete;
				}
				timer_.Start();
				PlaySound();
			}
		}

		private static void OnComplete(object s, ElapsedEventArgs e)
		{
			lockSound = false;
		}

		private static void PlaySound()
		{
			SoundProvider.PlaySingleSound2D(14);
		}
	}
}
