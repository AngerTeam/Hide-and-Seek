using HudSystem;
using InventoryModule;
using PlayerModule.MyPlayer;

namespace InventoryViewModule
{
	public class SelectedArtikulHud : HeadUpDisplay
	{
		private MyPlayerStatsModel myPlayerModel_;

		private DescriptionPanelHierarchy panel_;

		private int reportedArtikul_;

		public SelectedArtikulHud()
		{
			prefabsManager.Load("InventotyPrefabHolder");
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerModel_);
			myPlayerModel_.stats.SelectedArtikulChanged += OnSelectedItemChanged;
			panel_ = prefabsManager.InstantiateNGUIIn<DescriptionPanelHierarchy>("UIDescriptionWidget", nguiManager.UiRoot.PlayerPanelContainer.gameObject);
			panel_.widget.SetAnchor(nguiManager.UiRoot.PlayerPanelContainer.transform);
			HudStateItem hudStateItem = new HudStateItem(panel_);
			hudStateItem.Activated += Reset;
			hudStateSwitcher.Register(67108864, hudStateItem);
			hudStateSwitcher.Register(2, hudStateItem);
		}

		private void Reset(int state)
		{
			panel_.DescriptionLabel.text = string.Empty;
		}

		public override void Dispose()
		{
			myPlayerModel_.stats.SelectedArtikulChanged -= OnSelectedItemChanged;
		}

		private void OnSelectedItemChanged(int artikulId)
		{
			if (reportedArtikul_ == artikulId)
			{
				return;
			}
			reportedArtikul_ = artikulId;
			if (panel_.gameObject.activeSelf)
			{
				Log.Info("OnSelectedItemChanged");
				ArtikulsEntries value;
				if (InventoryContentMap.Artikuls.TryGetValue(artikulId, out value))
				{
					panel_.DescriptionLabel.text = value.title;
					panel_.DescriptionTween.ResetToBeginning();
					panel_.DescriptionTween.PlayForward();
				}
			}
		}
	}
}
