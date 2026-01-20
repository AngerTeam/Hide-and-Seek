using CraftyEngine.Infrastructure;
using HudSystem;
using InventoryViewModule;
using PlayerModule.MyPlayer;
using ShopModule;
using WebViewModule;
using WindowsModule;

public class ExporterWindow : GameWindow
{
	private PlayerSkinsManager playerSkinsManager_;

	private MyPlayerStatsModel playerStatsManager_;

	private ExporterWindowHierarchy windowHierarchy_;

	private CatalogLoader<SkinItem> skins_;

	private SkinItem currentSkin_;

	public ExporterWindow()
		: base(true, false)
	{
		prefabsManager.Load("ExporterModule");
		SingletonManager.Get<PlayerSkinsManager>(out playerSkinsManager_);
		SingletonManager.Get<MyPlayerStatsModel>(out playerStatsManager_);
		windowHierarchy_ = prefabsManager.InstantiateNGUIIn<ExporterWindowHierarchy>("UIExporterWindow", nguiManager.UiRoot.gameObject);
		windowHierarchy_.ExportButtonLabel.text = Localisations.Get("UI_Export");
		SetContent(windowHierarchy_.transform, true, true, false, false, true);
		skins_ = new CatalogLoader<SkinItem>();
		ButtonSet.Up(windowHierarchy_.ExportButton, OnExport, ButtonSetGroup.InWindow);
		base.Hierarchy.closeButton = windowHierarchy_.CloseButton;
		windowHierarchy_.CloseButtonLabel.text = Localisations.Get("UI_Close");
		ButtonSet.Up(windowHierarchy_.CloseButton, OnClose, ButtonSetGroup.InWindow);
		base.ViewChanged += OnViewChanged;
	}

	private void OnViewChanged(object sender, BoolEventArguments e)
	{
		if (Visible)
		{
			BuildSkins();
			skins_.Load();
			PreviewCurrentSkin();
			UpdateAllSkinsButtons();
		}
		else
		{
			skins_.Unload();
		}
		UnityEvent.OnNextUpdate(ResetScroll);
	}

	private void OnExport()
	{
		if (currentSkin_ != null)
		{
			string text = "https://minecraft.net/en-us/profile/skin/remote?url=";
			string text2 = "https://deploy.hns.pixelgun.plus/public/" + currentSkin_.entry.skinData.GetFullPicturePath();
			text += text2;
			WebViewHandler webViewHandler = SingletonManager.Get<WebViewHandler>();
			webViewHandler.OpenURL(text);
		}
	}

	private void OnClose()
	{
		windowsManager.ToggleWindow(this);
	}

	private void BuildSkins()
	{
		if (playerSkinsManager_.Skins == null || playerSkinsManager_.Skins.Count == 0)
		{
			Log.Error("ERROR: Skins not found.");
			return;
		}
		foreach (SkinEntryView skin in playerSkinsManager_.Skins)
		{
			if (skin.isBought && !SkinExist(skin.skinData.id) && (skin.skinData.selectable == 1 || skin.skinData.sale_on == 1) && !string.IsNullOrEmpty(skin.skinData.preview_picture))
			{
				AddSkin(skin);
			}
		}
	}

	private bool SkinExist(int id)
	{
		if (skins_ == null || skins_.Items.Count == 0)
		{
			return false;
		}
		foreach (SkinItem item in skins_.Items)
		{
			if (item.skinId == id)
			{
				return true;
			}
		}
		return false;
	}

	private void AddSkin(SkinEntryView skinEntry)
	{
		SkinItemHierarchy skinItemHierarchy = prefabsManager.InstantiateNGUIIn<SkinItemHierarchy>("UISkinItem", windowHierarchy_.ContentsGrid.gameObject);
		SkinItem item = skins_.Add(skinItemHierarchy.rollerWidget, skinItemHierarchy.image, skins_.Check(skinEntry.skinData.preview_picture, skinEntry.skinData.GetFullPreviewPicturePath));
		item.entry = skinEntry;
		item.skinId = skinEntry.skinData.id;
		item.hierarchy = skinItemHierarchy;
		item.hierarchy.price.text = skinEntry.skinData.money_cnt.ToString();
		ButtonSet.Up(item.hierarchy.button, delegate
		{
			PreviewSkin(item);
		}, ButtonSetGroup.InWindow);
	}

	private void UpdateAllSkinsButtons()
	{
		foreach (SkinItem item in skins_.Items)
		{
			item.hierarchy.price.gameObject.SetActive(false);
			item.hierarchy.currentlySelectedSprite.gameObject.SetActive(false);
		}
	}

	private void PreviewCurrentSkin()
	{
		foreach (SkinItem item in skins_.Items)
		{
			if (item.skinId == playerStatsManager_.stats.SkinId)
			{
				PreviewSkin(item);
				break;
			}
		}
	}

	private void PreviewSkin(SkinItem item)
	{
		currentSkin_ = item;
		windowHierarchy_.DescriptionLabel.text = item.entry.skinData.title;
		foreach (SkinItem item2 in skins_.Items)
		{
			item2.hierarchy.selectionSprite.gameObject.SetActive(item2.skinId == currentSkin_.skinId);
		}
	}

	private void ResetScroll()
	{
		windowHierarchy_.ScrollView.InvalidateBounds();
		windowHierarchy_.ScrollView.ResetPosition();
		windowHierarchy_.ContentsGrid.Reposition();
	}
}
