using System;
using CraftyEngine.Utils.Unity;
using CraftyGameEngine.Player;
using InventoryModule;
using PlayerModule;
using PlayerModule.MyPlayer;
using PlayerModule.Playmate;
using UnityEngine;

namespace CraftyGameEngine.Gui
{
	public class ShopStateController : IDisposable
	{
		private PlayerStatsModel modelCopy_;

		private ActorHolderUI3D actorHolder_;

		private ActorRotator actorRotator_;

		private MyPlayerStatsModel myPlayerManager_;

		private PlaymateEntity actor_;

		private Transform parent_;

		public ShopStateController(Transform parent, bool isDummy = true)
		{
			parent_ = parent;
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerManager_);
			modelCopy_ = PlayerStatsModel.Clone(myPlayerManager_.stats);
			modelCopy_.IsDummy = isDummy;
		}

		public void CreateActor()
		{
			if (actorHolder_ == null)
			{
				actorHolder_ = new ActorHolderUI3D();
				actorHolder_.AddActor(isDummy: modelCopy_.IsDummy, model: modelCopy_, parent: parent_, permanent: true, scale: 1f, heightOffset: -0.83f);
				actor_ = actorHolder_.PlaymateEntity;
				actorRotator_ = new ActorRotator(modelCopy_);
			}
		}

		public void SwitchActorSkin(int skinId)
		{
			modelCopy_.SkinId = skinId;
		}

		public void SetHandItem(ushort handArtikul, bool allItems = false)
		{
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(handArtikul, out value))
			{
				if (!allItems && value.type_id != 3 && value.type_id != 4)
				{
					handArtikul = (ushort)InventoryContentMap.CraftSettings.handArtikul.id;
				}
				modelCopy_.SelectedArtikul = handArtikul;
				if (actor_ != null && actor_.Model.visual.Transform != null)
				{
					GameObjectUtils.SetLayer(actor_.Model.visual.Transform.gameObject, 16);
				}
			}
		}

		public void ToggleFlauntActor()
		{
			if (actorHolder_ != null)
			{
				actorHolder_.SetFlaunt();
			}
		}

		public void SwitchActor(bool on)
		{
			if (actorHolder_ != null)
			{
				actorHolder_.SwitchActive(on);
			}
		}

		public void SetAction(int actionId)
		{
			if (actorHolder_ != null)
			{
				actorHolder_.SetAction(actionId);
			}
		}

		public void Dispose()
		{
			if (actorHolder_ != null)
			{
				actorHolder_.DisposeActor();
				actorHolder_ = null;
				actorRotator_.Dispose();
			}
		}
	}
}
