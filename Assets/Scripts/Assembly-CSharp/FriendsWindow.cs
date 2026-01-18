using CraftyEngine.Infrastructure;
using FriendsModule;
using HudSystem;
using InventoryViewModule;
using WindowsModule;

public class FriendsWindow : GameWindow
{
	private const int FRIENDS_TAB = 0;

	private const int REQUESTS_TAB = 1;

	private const int SEARCH_TAB = 2;

	private FriendsModel model_;

	private FriendsController friendsController_;

	private FriendsWindowHierarchy windowHierarchy_;

	private FriendsSubWindow friendsSubWindow_;

	private RequestsSubWindow requestsSubWindow_;

	private SearchPlayerSubWindow searchSubWindow_;

	private TabsWidgetWithSubwindows tabs_;

	private Tab activeTab_;

	public FriendsWindow()
		: base(false, false)
	{
		prefabsManager.Load("FriendsModule");
		SingletonManager.Get<FriendsController>(out friendsController_);
		SingletonManager.Get<FriendsModel>(out model_);
		tabs_ = new TabsWidgetWithSubwindows(null, true, false);
		tabs_.hierarchy.title.text = string.Empty;
		tabs_.hierarchy.contentContainer.bottomAnchor.absolute = 50;
		SetContent(tabs_.hierarchy.transform, true, true, false, false, true);
		friendsSubWindow_ = tabs_.AddSubWindow<FriendsSubWindow>(string.Empty);
		requestsSubWindow_ = tabs_.AddSubWindow<RequestsSubWindow>(string.Empty);
		searchSubWindow_ = tabs_.AddSubWindow<SearchPlayerSubWindow>(string.Empty);
		base.HeavyGraphics = true;
		windowHierarchy_ = prefabsManager.InstantiateNGUIIn<FriendsWindowHierarchy>("UIFriendsWindow", tabs_.hierarchy.contentContainer.gameObject);
		base.Hierarchy.closeButton = windowHierarchy_.CloseButton;
		ButtonSet.Up(windowHierarchy_.CloseButton, HandleCloseWindow, ButtonSetGroup.InWindow);
	}

	public override void Resubscribe()
	{
		base.Resubscribe();
		tabs_.TabActivated += HandleTabActivate;
		base.ViewChanged += HandleViewChanged;
		base.IsFrontChanged += HandleIsFrontChanged;
	}

	public override void Dispose()
	{
		base.Dispose();
		tabs_.TabActivated -= HandleTabActivate;
		base.ViewChanged -= HandleViewChanged;
		base.IsFrontChanged -= HandleIsFrontChanged;
	}

	private void HandleCloseWindow()
	{
		windowsManager.ToggleWindow(this);
	}

	private void HandlePointerClicked()
	{
		friendsSubWindow_.HideInfoPopup();
		requestsSubWindow_.HideInfoPopup();
		searchSubWindow_.HideInfoPopup();
	}

	private void HandleFriendsUpdated()
	{
		if (tabs_ != null && activeTab_ != null)
		{
			tabs_.Windows[2].tab.hierarchy.title.text = Localisations.Get("UI_Find_Friends");
			string arg = ((model_.friends == null || model_.friends.Length <= 0) ? string.Empty : ("([FFEE14]" + model_.friends.Length + "[-])"));
			tabs_.Windows[0].tab.hierarchy.title.text = string.Format("{0} {1}", Localisations.Get("UI_Friends"), arg);
			string arg2 = ((model_.input == null || model_.input.Length <= 0) ? string.Empty : ("([FFEE14]" + model_.input.Length + "[-])"));
			tabs_.Windows[1].tab.hierarchy.title.text = string.Format("{0} {1}", Localisations.Get("UI_Requests"), arg2);
			friendsSubWindow_.Init();
			requestsSubWindow_.Init();
			searchSubWindow_.Update();
		}
	}

	private void HandlePlayersUpdated()
	{
		if (tabs_ != null)
		{
			searchSubWindow_.Init();
		}
	}

	private void HandleIsFrontChanged(object sender, BoolEventArguments e)
	{
		windowHierarchy_.CloseButton.gameObject.SetActive(base.IsFront);
		if (activeTab_ != null)
		{
			if (base.IsFront)
			{
				tabs_.Windows[activeTab_.index].window.Show();
			}
			else
			{
				tabs_.Windows[activeTab_.index].window.Hide();
			}
		}
	}

	private void HandleViewChanged(object sender, BoolEventArguments e)
	{
		if (Visible)
		{
			tabs_.ActivateTab(0);
			friendsController_.FriendsUpdated += HandleFriendsUpdated;
			friendsController_.PlayersUpdated += HandlePlayersUpdated;
			friendsController_.PointerClicked += HandlePointerClicked;
			friendsController_.GetFriends();
		}
		else
		{
			friendsController_.FriendsUpdated -= HandleFriendsUpdated;
			friendsController_.PlayersUpdated -= HandlePlayersUpdated;
			friendsController_.PointerClicked -= HandlePointerClicked;
			model_.Clear();
		}
	}

	private void HandleTabActivate(Tab activeTab)
	{
		if (activeTab_ != null)
		{
			tabs_.Windows[activeTab_.index].window.Hide();
		}
		activeTab_ = activeTab;
		tabs_.Windows[activeTab_.index].window.Show();
	}
}
