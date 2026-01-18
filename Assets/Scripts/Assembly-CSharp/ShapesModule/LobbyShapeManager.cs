using System.Collections.Generic;
using ChestsViewModule;
using ChestsViewModule.Content;
using CraftyEngine.Infrastructure;

namespace ShapesModule
{
	public class LobbyShapeManager : Singleton
	{
		private ShapeManager shapeManager_;

		private ChestsManager chestsManager_;

		private QueueManager queueManager_;

		private ShapeInstance ChestInformer;

		public override void Init()
		{
			SingletonManager.Get<ShapeManager>(out shapeManager_);
			SingletonManager.Get<ChestsManager>(out chestsManager_);
			SingletonManager.Get<QueueManager>(out queueManager_);
			chestsManager_.AnimateInformerChest += AnimateChest;
		}

		public override void OnDataLoaded()
		{
			shapeManager_.InitLoading(PreProcessShapes(1));
			queueManager_.AddTask(SetChestInformer);
		}

		public List<ShapeInstanceEntries> PreProcessShapes(int templateId)
		{
			List<ShapeInstanceEntries> list = new List<ShapeInstanceEntries>();
			foreach (IslandObjectsEntries value in ShapesContentMap.IslandObjects.Values)
			{
				if (value.template_id == templateId)
				{
					value.isPassable = BitMath.GetBit((byte)value.flags, 0);
					list.Add(value);
				}
			}
			return list;
		}

		public void SetChestInformer()
		{
			foreach (ShapeInstance shape in shapeManager_.Shapes)
			{
				if (chestsManager_ != null && shape.shapeObject != null && shape.IslandObject != null && shape.IslandObject.id == ChestsContentMap.ChestSettings.REWARD_CHEST_ID)
				{
					ChestInformer = shape;
					chestsManager_.SetChestInformer(ChestInformer.shapeObject.transform);
				}
			}
		}

		private void AnimateChest(string animation)
		{
			if (ChestInformer != null && ChestInformer.shapeObject != null)
			{
				ChestInformer.Animate(animation);
			}
		}

		public override void Dispose()
		{
			chestsManager_.AnimateInformerChest -= AnimateChest;
		}
	}
}
