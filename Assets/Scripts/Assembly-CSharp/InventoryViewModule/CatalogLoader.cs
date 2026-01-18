using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using DG.Tweening;
using NguiTools;
using UnityEngine;

namespace InventoryViewModule
{
	public class CatalogLoader<T> where T : CatalogItem, new()
	{
		public bool lowRam;

		public int preloadAmount;

		private NguiFileManager getSetFileManager_;

		private TaskQueue queue_;

		public List<T> Items { get; private set; }

		public CatalogLoader(int preloadAmount = 3)
		{
			Items = new List<T>();
			this.preloadAmount = preloadAmount;
			SingletonManager.Get<NguiFileManager>(out getSetFileManager_);
			lowRam = SystemInfo.systemMemorySize < 600;
		}

		public T Add()
		{
			T val = new T();
			Items.Add(val);
			return val;
		}

		public T Add(UIWidget widget, UITexture image, string imageUrl, UITexture preview = null, string previewUrl = null)
		{
			T val = Add();
			Render(val, widget, image, imageUrl, preview, previewUrl);
			return val;
		}

		public string Check(string url, Func<string> fullPath)
		{
			return (!string.IsNullOrEmpty(url)) ? fullPath() : null;
		}

		public void Load()
		{
			QueueManager queueManager = SingletonManager.Get<QueueManager>();
			queue_ = queueManager.AddUnityThreadQueue();
			SingletonManager.Get<NguiFileManager>(out getSetFileManager_);
			foreach (T item in Items)
			{
				if (item.preload || (item.image.mainTexture != null && item.file != null && item.file.fileGetter.State == LoadState.Loaded))
				{
					continue;
				}
				if (item.preview != null)
				{
					item.preview.gameObject.SetActive(true);
				}
				item.roller.Widget.gameObject.SetActive(true);
				if (item.file == null || item.file.fileGetter.State == LoadState.Unloaded)
				{
					if (!string.IsNullOrEmpty(item.imageUrl))
					{
						item.file = getSetFileManager_.SetUiTexture(item.image, item.imageUrl, queue_);
					}
				}
				else
				{
					getSetFileManager_.SetUiTexture(item.image, item.file, queue_);
				}
				T lamda = item;
				queueManager.AddTask(delegate
				{
					HideRoller(lamda);
				}, queue_);
				if (lowRam)
				{
					queueManager.AddTask(new WaitTask(0.1f), queue_);
				}
			}
		}

		public void Render(T item, UIWidget widget, UITexture image, string imageUrl, UITexture preview, string previewUrl)
		{
			bool flag = Items.Count < preloadAmount;
			item.widget = widget;
			item.image = image;
			item.imageUrl = imageUrl;
			item.preview = preview;
			item.preload = flag;
			item.roller = new UiRoller(widget);
			item.roller.Widget.gameObject.SetActive(false);
			item.roller.Widget.depth = 100;
			if (flag)
			{
				item.file = getSetFileManager_.SetUiTexture(image, imageUrl);
				if (preview != null)
				{
					preview.gameObject.SetActive(false);
				}
			}
			else
			{
				image.color = new Color(1f, 1f, 1f, 0f);
				if (!string.IsNullOrEmpty(previewUrl) && preview != null)
				{
					getSetFileManager_.SetUiTexture(preview, previewUrl);
				}
			}
		}

		public void Unload()
		{
			if (queue_ != null)
			{
				queue_.Clear();
			}
			FilesManager filesManager = SingletonManager.Get<FilesManager>();
			foreach (T item in Items)
			{
				if (!item.preload)
				{
					item.image.mainTexture = null;
					item.image.color = new Color(1f, 1f, 1f, 0f);
					if (item.file != null && lowRam)
					{
						filesManager.Unload(item.file);
						item.file = null;
					}
				}
			}
			if (lowRam)
			{
				Resources.UnloadUnusedAssets();
			}
		}

		private void HideRoller(T item)
		{
			item.roller.Widget.gameObject.SetActive(false);
			item.widget.ResetAndUpdateAnchors();
			if (item.widget.isVisible)
			{
				Tweener t = DOTween.To(() => item.image.color, delegate(Color c)
				{
					item.image.color = c;
				}, Color.white, 1f);
				if (item.preview != null)
				{
					t.OnComplete(delegate
					{
						item.preview.gameObject.SetActive(false);
					});
				}
			}
			else
			{
				item.image.color = Color.white;
				if (item.preview != null)
				{
					item.preview.gameObject.SetActive(false);
				}
			}
		}
	}
}
