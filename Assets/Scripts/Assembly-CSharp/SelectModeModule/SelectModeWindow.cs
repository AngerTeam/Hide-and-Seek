using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using HudSystem;
using NguiTools;
using PvpModule.Content;
using WindowsModule;

namespace SelectModeModule
{
	public class SelectModeWindow : GameWindow
	{
		private NguiFileManager nguiFileManager_;

		private SelectModeWindowHierarchy hierarchy_;

		private bool inited_;

		public SelectModeWindow()
			: base(false)
		{
			base.ExclusiveGroup = 3;
			base.HudState = 41088;
			SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
			prefabsManager.Load("SelectModeModulePrefabsHolder");
			hierarchy_ = prefabsManager.InstantiateNGUIIn<SelectModeWindowHierarchy>("UISelectModeWindow", nguiManager.UiRoot.gameObject);
			hierarchy_.title.text = Localisations.Get("UI_SelectModeWindowTitle");
			SetContent(hierarchy_.gameObject.transform, true, true, false, false, true);
			base.ViewChanged += HandleViewChanged;
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (!Visible || inited_)
			{
				return;
			}
			inited_ = true;
			List<PvpModesEntries> list = new List<PvpModesEntries>();
			list.AddRange(PvpModuleContentMap.PvpModes.Values);
			list.Sort((PvpModesEntries a, PvpModesEntries b) => a.sort_val.CompareTo(b.sort_val));
			foreach (PvpModesEntries item in list)
			{
				if (item.is_active == 0)
				{
					continue;
				}
				SelectModeItemHierarchy selectModeItemHierarchy = prefabsManager.InstantiateNGUIIn<SelectModeItemHierarchy>("UISelectModeItem", hierarchy_.grid.gameObject);
				if (!string.IsNullOrEmpty(item.icon))
				{
					nguiFileManager_.SetUiTexture(selectModeItemHierarchy.icon, item.GetFullIconPath());
				}
				selectModeItemHierarchy.title.text = item.title;
				bool flag = item.comming_soon == 1;
				selectModeItemHierarchy.comingSoonWidget.gameObject.SetActive(flag);
				if (flag)
				{
					selectModeItemHierarchy.comingSoonLabel.text = Localisations.Get("UI_Level_ComingSoon");
					continue;
				}
				int modeId = item.id;
				ButtonSet.Up(selectModeItemHierarchy.button, delegate
				{
					SelectMode(modeId);
				}, ButtonSetGroup.InWindow);
			}
			hierarchy_.grid.repositionNow = true;
		}

		private void SelectMode(int modeId)
		{
			SelectMapWindow selectMapWindow = GuiModuleHolder.Get<SelectMapWindow>();
			selectMapWindow.OpenWindow(modeId);
		}
	}
}
