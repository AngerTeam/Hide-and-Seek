using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using Extensions;
using HudSystem;
using NewsModule;
using NguiTools;
using UnityEngine;
using WindowsModule;

public class NewsWindow : GameWindow
{
	private NewsModuleManager newsManager_;

	private NguiFileManager nGuiFileManager_;

	private NewsWindowHierarchy windowHierarchy_;

	private NewsInformerHierarchy informerHierarchy_;

	private HudStateSwitcher hudStateSwitcher_;

	private QueueManager queueManager_;

	private TaskQueue queue_;

	private UiRoller roller_;

	private List<NewsItem> catalogNews_;

	private NewsItem selectedNews_;

	public event Action OpenNewsWindow;

	public NewsWindow()
		: base(false)
	{
		prefabsManager.Load("NewsModule");
		SingletonManager.Get<NewsModuleManager>(out newsManager_);
		SingletonManager.Get<NguiFileManager>(out nGuiFileManager_);
		SingletonManager.Get<QueueManager>(out queueManager_);
		SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher_);
		catalogNews_ = new List<NewsItem>();
		queue_ = queueManager_.AddUnityThreadQueue();
		windowHierarchy_ = prefabsManager.InstantiateNGUIIn<NewsWindowHierarchy>("UINewsWindow", nguiManager.UiRoot.gameObject);
		windowHierarchy_.Title.text = Localisations.Get("UI_News_Title");
		SetContent(windowHierarchy_.transform, false);
		roller_ = new UiRoller(windowHierarchy_.ContentHierarchy.roller);
		roller_.Widget.gameObject.SetActive(false);
		base.ViewChanged += HandleViewChanged;
		GenerateNews();
		SortNews();
		SelectFirstNews();
	}

	public override void Resubscribe()
	{
		base.Resubscribe();
		queue_.TaskAdded += HandleTaskAdded;
		queue_.AllTasksCompleted += HandleTaskComplete;
	}

	public override void Dispose()
	{
		base.Dispose();
		queue_.TaskAdded -= HandleTaskAdded;
		queue_.AllTasksCompleted -= HandleTaskComplete;
		queue_.Dispose();
		roller_.Dispose();
	}

	private NewsItem GetNews(int newsId)
	{
		if (catalogNews_ == null || catalogNews_.Count == 0)
		{
			return null;
		}
		foreach (NewsItem item in catalogNews_)
		{
			if (item.newsId == newsId)
			{
				return item;
			}
		}
		return null;
	}

	public void UpdateInformer()
	{
		if (!(informerHierarchy_ == null) && !newsManager_.HasNewNews())
		{
			UnityEngine.Object.Destroy(informerHierarchy_.gameObject);
		}
	}

	public void GenerateInformer()
	{
		if (newsManager_.HasNewNews())
		{
			informerHierarchy_ = prefabsManager.InstantiateNGUIIn<NewsInformerHierarchy>("UINewsInformer", nguiManager.UiRoot.gameObject);
			informerHierarchy_.Panel.depth = 55;
			ButtonSet.Up(informerHierarchy_.Button, HandleOpenWindow, ButtonSetGroup.InWindow);
			hudStateSwitcher_.Register(8352, informerHierarchy_.Button);
		}
	}

	private void GenerateNews()
	{
		if (NewsContentMap.News == null || NewsContentMap.News.Count == 0)
		{
			return;
		}
		foreach (NewsEntries value in NewsContentMap.News.Values)
		{
			AddNews(value);
		}
	}

	private void SortNews()
	{
		if (catalogNews_ != null && catalogNews_.Count != 0)
		{
			catalogNews_.Sort((NewsItem p, NewsItem q) => q.entry.sort_val.CompareTo(p.entry.sort_val));
			windowHierarchy_.NewsGrid.Sort(catalogNews_);
		}
	}

	private void AddNews(NewsEntries entry)
	{
		NewsItemHierarchy newsItemHierarchy = prefabsManager.InstantiateNGUIIn<NewsItemHierarchy>("UINewsItem", windowHierarchy_.NewsGrid.gameObject);
		DateTime result;
		if (DateTime.TryParse(entry.news_date, out result))
		{
			string text = string.Format("{0}.{1}.{2}", result.Day.ToString("00"), result.Month.ToString("00"), result.Year.ToString("00"));
			newsItemHierarchy.date.text = text;
		}
		newsItemHierarchy.title.text = entry.adt_title;
		newsItemHierarchy.description.text = entry.adt_text;
		newsItemHierarchy.select.gameObject.SetActive(false);
		UIDragScrollView uIDragScrollView = newsItemHierarchy.gameObject.AddComponent<UIDragScrollView>();
		uIDragScrollView.scrollView = windowHierarchy_.NewsScrollView;
		if (!string.IsNullOrEmpty(entry.icon))
		{
			nGuiFileManager_.SetUiTexture(newsItemHierarchy.icon, entry.GetFullIconPath());
		}
		catalogNews_.Add(new NewsItem(newsItemHierarchy, entry, entry.id));
		ButtonSet.Up(newsItemHierarchy.button, delegate
		{
			SelectNews(entry.id);
		}, ButtonSetGroup.InWindow);
	}

	private void SelectNews(int newsId)
	{
		if (selectedNews_ != null)
		{
			selectedNews_.hierarchy.select.gameObject.SetActive(false);
		}
		selectedNews_ = GetNews(newsId);
		if (selectedNews_ != null)
		{
			windowHierarchy_.ContentHierarchy.scrollView.ResetPosition();
			roller_.Widget.gameObject.SetActive(false);
			DateTime result;
			if (DateTime.TryParse(selectedNews_.entry.news_date, out result))
			{
				string text = string.Format("{0}.{1}.{2}", result.Day.ToString("00"), result.Month.ToString("00"), result.Year.ToString("00"));
				windowHierarchy_.ContentHierarchy.date.text = text;
			}
			windowHierarchy_.ContentHierarchy.title.text = selectedNews_.entry.news_title;
			windowHierarchy_.ContentHierarchy.description.text = selectedNews_.entry.news_text;
			windowHierarchy_.ContentHierarchy.image.mainTexture = null;
			if (!string.IsNullOrEmpty(selectedNews_.entry.picture))
			{
				nGuiFileManager_.SetUiTexture(windowHierarchy_.ContentHierarchy.image, selectedNews_.entry.GetFullPicturePath(), queue_);
			}
			selectedNews_.hierarchy.select.gameObject.SetActive(true);
		}
	}

	private void SelectFirstNews()
	{
		using (List<NewsItem>.Enumerator enumerator = catalogNews_.GetEnumerator())
		{
			if (enumerator.MoveNext())
			{
				NewsItem current = enumerator.Current;
				SelectNews(current.newsId);
			}
		}
	}

	private void HandleOpenWindow()
	{
		WindowsManagerShortcut.ToggleWindow<NewsWindow>();
	}

	private void HandleViewChanged(object sender, BoolEventArguments e)
	{
		if (Visible)
		{
			this.OpenNewsWindow.SafeInvoke();
		}
		UpdateInformer();
	}

	private void HandleTaskAdded(object sender, EventArgs e)
	{
		roller_.Widget.gameObject.SetActive(true);
	}

	private void HandleTaskComplete(object sender, EventArgs e)
	{
		roller_.Widget.gameObject.SetActive(false);
	}
}
