namespace Animations
{
	public class AnimatedCustomView : AnimatedItemView
	{
		public AnimatedCustomView(AnimationType type, int layerCount = 2)
		{
			base.type = type;
			base.Asc = new AnimatorOverrideStatesController(layerCount, "SpliDynamicController", 15);
			TryLoadDefaultAnimations();
		}
	}
}
