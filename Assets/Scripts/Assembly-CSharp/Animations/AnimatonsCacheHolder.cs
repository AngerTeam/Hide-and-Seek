using CraftyEngine.Content;
using CraftyEngine.Infrastructure.FileSystem;

namespace Animations
{
	public class AnimatonsCacheHolder : Singleton
	{
		public bool split;

		public AnimatorOverrideStatesController statesController;

		public AnimatorLayerHolder animationItemMelee;

		public AnimatorLayerHolder animationMelee;

		public AnimatorLayerHolder animationRun;

		private FileHolder animationMeleeFile_;

		private FileHolder animationRunFile_;

		private FileHolder animationItemMeleeFile_;

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<AnimationsContentMap>();
			animationMelee = new AnimatorLayerHolder();
			animationRun = new AnimatorLayerHolder();
			animationItemMelee = new AnimatorLayerHolder();
			Load();
		}

		private void Load()
		{
			AnimationsFileManager animationsFileManager = SingletonManager.Get<AnimationsFileManager>(1);
			animationsFileManager.GetAnimation(out animationRunFile_, AnimationsContentMap.AnimationSettings.ANIMATIONS_ID_RUN, split);
			animationsFileManager.GetAnimation(out animationMeleeFile_, AnimationsContentMap.AnimationSettings.ANIMATIONS_ID_MELEE, split);
			animationsFileManager.GetAnimation(out animationItemMeleeFile_, AnimationsContentMap.AnimationSettings.ANIMATIONS_ID_MELEE_ITEM, split, InitAnimator);
		}

		private void InitAnimator(FileHolder file)
		{
			animationMelee.SetData(animationMeleeFile_, AnimationsContentMap.AnimationSettings.ANIMATIONS_ID_MELEE);
			animationRun.SetData(animationRunFile_, AnimationsContentMap.AnimationSettings.ANIMATIONS_ID_RUN);
			animationItemMelee.SetData(animationItemMeleeFile_, AnimationsContentMap.AnimationSettings.ANIMATIONS_ID_MELEE_ITEM);
			CreateStatesController();
		}

		private void CreateStatesController()
		{
			statesController = new AnimatorOverrideStatesController(1);
			statesController.SetHolder(animationRun, 0);
			statesController.cacheStates = true;
		}
	}
}
