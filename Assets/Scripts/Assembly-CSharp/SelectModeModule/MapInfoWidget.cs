using NguiTools;
using PvpModule.Content;
using UnityEngine;

namespace SelectModeModule
{
	public class MapInfoWidget
	{
		private NguiFileManager nguiFileManager_;

		private MapInfoWidgetHierarchy hierarchy_;

		public MapInfoWidget(Transform parent)
		{
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
			singlton.Load("SelectModeModulePrefabsHolder");
			hierarchy_ = singlton.InstantiateNGUIIn<MapInfoWidgetHierarchy>("UIResMapInfoWidget", parent.gameObject);
			hierarchy_.widget.SetAnchor(parent.gameObject, 0, 0, 0, 0);
			hierarchy_.mode.title.text = Localisations.Get("MapInfoWindow_GameMode");
			new UiRoller(hierarchy_.mapRoller);
		}

		public void SetMapInfo(SelectMapItem selectedItem, int instancesCount = 0)
		{
			hierarchy_.title.text = selectedItem.Title;
			hierarchy_.sizeLabel.text = MapSizes.ToTitleText(selectedItem.MapSize);
			hierarchy_.icon.mainTexture = null;
			if (!string.IsNullOrEmpty(selectedItem.Picture))
			{
				nguiFileManager_.SetUiTexture(hierarchy_.icon, selectedItem.Picture);
			}
			PvpModesEntries value;
			if (PvpModuleContentMap.PvpModes.TryGetValue(selectedItem.ViewModeId, out value))
			{
				hierarchy_.mode.value.text = value.title;
			}
			else
			{
				hierarchy_.mode.value.text = string.Empty;
			}
			for (int i = 0; i < hierarchy_.countItems.Length; i++)
			{
				bool active = instancesCount > i;
				hierarchy_.countItems[i].gameObject.SetActive(active);
			}
		}
	}
}
