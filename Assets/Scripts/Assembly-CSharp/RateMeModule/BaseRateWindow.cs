using WindowsModule;

namespace RateMeModule
{
	public class BaseRateWindow : GameWindow
	{
		protected string emptySpriteName;

		protected string fullSpriteName;

		protected UIButton[] starsButtons;

		public BaseRateWindow(bool back, bool closeButton)
			: base(back, closeButton)
		{
		}

		protected void SetRateElements(UIButton[] stars, string emptySprite, string fullSprite)
		{
			starsButtons = stars;
			emptySpriteName = emptySprite;
			fullSpriteName = fullSprite;
			SwapSprites(0);
			for (int i = 0; i < starsButtons.Length; i++)
			{
				int lambda = i + 1;
				UIButton uIButton = starsButtons[i];
				EventDelegate.Add(uIButton.onClick, delegate
				{
					Rate(lambda);
				});
			}
		}

		protected virtual void Rate(int value)
		{
			SwapSprites(value);
		}

		protected void SwapSprites(int rate)
		{
			for (int i = 0; i < starsButtons.Length; i++)
			{
				UISprite component = starsButtons[i].GetComponent<UISprite>();
				component.spriteName = ((rate <= i) ? emptySpriteName : fullSpriteName);
			}
		}
	}
}
