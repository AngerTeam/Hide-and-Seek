using System.Collections.Generic;
using Authorization;
using HideAndSeekGame;
using Prompts;

namespace ShapesModule
{
	public class TutorialShapeManager : Singleton
	{
		private ShapeManager shapeManager_;

		public override void Init()
		{
			SingletonManager.Get<ShapeManager>(out shapeManager_);
			shapeManager_.ShapeEntered += ShapeEnter;
		}

		private void ShapeEnter(ShapeInstance shape)
		{
			if (shape.typeId == HideAndSeekGameMap.GameConstants.FINISH_LEVEL_TASK)
			{
				AuthorizationModel singlton;
				SingletonManager.Get<AuthorizationModel>(out singlton);
				singlton.newUser = false;
			}
		}

		public void Start()
		{
			shapeManager_.InitLoading(PreProcessShapes(PromptsMap.Tutorial.TUTORIAL_LEVEL_ID));
		}

		private List<ShapeInstanceEntries> PreProcessShapes(int levelId)
		{
			List<ShapeInstanceEntries> list = new List<ShapeInstanceEntries>();
			foreach (LocationObjectsEntries value in HideAndSeekGameMap.LocationObjects.Values)
			{
				if (value.location_id == levelId)
				{
					list.Add(value);
				}
			}
			foreach (ShapeInstanceEntries item in list)
			{
				item.isPassable = BitMath.GetBit((byte)item.flags, 0);
				if (item.type_id == HideAndSeekGameMap.GameConstants.FINISH_LEVEL_TASK)
				{
					item.bigCollider = true;
				}
			}
			return list;
		}

		public override void Dispose()
		{
			shapeManager_.ShapeEntered -= ShapeEnter;
		}
	}
}
