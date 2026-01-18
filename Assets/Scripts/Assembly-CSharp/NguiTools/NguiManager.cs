using CraftyBundles.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using UnityEngine;

namespace NguiTools
{
	public class NguiManager : PermanentSingleton
	{
		private string errorSpriteId_;

		private NguiAtlasHolder iconsAtlas_;

		private FileHolder iconsAtlasFileHolder_;

		public Texture AtlasTexture
		{
			get
			{
				return (iconsAtlas_ != null && !(iconsAtlas_.Prefab == null)) ? iconsAtlas_.Prefab.spriteMaterial.mainTexture : null;
			}
		}

		public UIRootHierarchy UiRoot { get; private set; }

		public override void Dispose()
		{
			if (UiRoot != null)
			{
				Object.Destroy(UiRoot.gameObject);
				UiRoot = null;
			}
		}

		private void FillIconsAtlas()
		{
			iconsAtlas_ = new NguiAtlasHolder
			{
				Prefab = iconsAtlasFileHolder_.loadedAssetBundle.LoadAsset<GameObject>("atlasicons.prefab").GetComponent<UIAtlas>(),
				Tex = iconsAtlasFileHolder_.loadedAssetBundle.LoadAsset<Texture2D>("atlasicons.png"),
				Mat = iconsAtlasFileHolder_.loadedAssetBundle.LoadAsset<Material>("atlasicons.mat")
			};
		}

		public override void Init()
		{
			InitUiRoot();
		}

		public void LoadIconAtlas()
		{
			if (iconsAtlasFileHolder_ == null)
			{
				FilesManager singleton;
				GetSingleton<FilesManager>(out singleton);
				QueueManager singleton2;
				GetSingleton<QueueManager>(out singleton2);
				string fullBundlePath = BundlesContentMap.Atlases[7].GetFullBundlePath();
				iconsAtlasFileHolder_ = singleton.AddLoadTask(fullBundlePath, FileType.UncompressedBundle);
				singleton2.AddTask(FillIconsAtlas);
			}
		}

		public override void OnDataLoaded()
		{
			if (!DataStorage.manualLoadOnly)
			{
				LoadIconAtlas();
			}
		}

		public void SetErrorSprite(string spriteId)
		{
			errorSpriteId_ = spriteId;
		}

		public bool SetIconSprite(UISprite spriteInstance, string spriteId)
		{
			if (spriteInstance != null && iconsAtlas_ != null)
			{
				spriteInstance.atlas = iconsAtlas_.Prefab;
				spriteInstance.spriteName = ((iconsAtlas_.Prefab.GetSprite(spriteId) == null) ? errorSpriteId_ : spriteId);
				return true;
			}
			return false;
		}

		internal UISpriteData GetSprite(string spriteId)
		{
			UISpriteData sprite = iconsAtlas_.Prefab.GetSprite(spriteId);
			if (sprite == null)
			{
				sprite = iconsAtlas_.Prefab.GetSprite(errorSpriteId_);
			}
			return sprite;
		}

		private void InitUiRoot()
		{
			PrefabsManagerNGUI prefabsManagerNGUI = SingletonManager.Get<PrefabsManagerNGUI>();
			prefabsManagerNGUI.Load("NguiPrefabsHolder");
			UiRoot = prefabsManagerNGUI.Instantiate<UIRootHierarchy>("UIRoot");
			Object.DontDestroyOnLoad(UiRoot.gameObject);
			UiRoot.UICamera.depth = 5f;
			UiRoot.ChestsCamera.depth = 6f;
			UiRoot.CommmonPanel.depth = 100;
			UiRoot.ControlsPanel.depth = 0;
			UiRoot.BlackBackPanel.depth = 75;
			UiRoot.CursorPanel.depth = 900;
			UiRoot.Cursor.InitCursor();
		}
	}
}
