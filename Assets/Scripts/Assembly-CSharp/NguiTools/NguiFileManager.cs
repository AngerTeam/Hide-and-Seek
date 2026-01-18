using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using UnityEngine;

namespace NguiTools
{
	public class NguiFileManager : Singleton
	{
		private FilesManager filesManager_;

		private QueueManager queueManager_;

		public override void Init()
		{
			GetSingleton<FilesManager>(out filesManager_);
			GetSingleton<QueueManager>(out queueManager_);
		}

		public void SetUI2DSprite(UI2DSprite sprite, string path)
		{
			if (!(path == string.Empty))
			{
				FilesManager filesManager = filesManager_;
				Action<FileHolder> callback = delegate(FileHolder fileholder)
				{
					UpdateIcon(sprite, fileholder);
				};
				filesManager.AddLoadTask(path, FileType.Texture, null, true, true, false, null, false, null, callback);
			}
		}

		public void SetUiTexture(UITexture texture, FileHolder fileholder, TaskQueue queue = null)
		{
			queueManager_.AddTask(fileholder.fileGetter, queue);
			queueManager_.AddTask(delegate
			{
				UpdateIcon(texture, fileholder);
			}, queue);
		}

		private void UpdateIcon(UITexture texture, FileHolder fileHolder)
		{
			texture.mainTexture = fileHolder.loadedTexture;
		}

		private void UpdateIcon(UI2DSprite sprite, FileHolder fileHolder)
		{
			sprite.sprite2D = Sprite.Create(fileHolder.loadedTexture, new Rect(0f, 0f, fileHolder.loadedTexture.width, fileHolder.loadedTexture.height), new Vector2(0.5f, 0.5f));
		}

		public FileHolder SetUiTexture(UITexture texture, string path, TaskQueue queue = null)
		{
			if (path == string.Empty)
			{
				return null;
			}
			FileHolder fileholder = filesManager_.AddLoadTask(path, FileType.Texture, queue);
			queueManager_.AddTask(delegate
			{
				UpdateIcon(texture, fileholder);
			}, queue);
			return fileholder;
		}
	}
}
