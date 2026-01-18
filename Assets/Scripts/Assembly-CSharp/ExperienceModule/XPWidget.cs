using HudSystem;
using NguiTools;
using UnityEngine;

namespace ExperienceModule
{
	public class XPWidget
	{
		private XPWidgetHierarchy xpWidgetHierarchy_;

		private NguiManager nguiManager_;

		private PrefabsManagerNGUI prefabsManager_;

		private HudStateSwitcher hudStateSwitcher_;

		public XPWidget()
		{
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher_);
			prefabsManager_.Load("ExpiriencePrefabsHolder");
			xpWidgetHierarchy_ = prefabsManager_.InstantiateNGUIIn<XPWidgetHierarchy>("UIXPWidget", nguiManager_.UiRoot.TopLeftContainer.gameObject);
			hudStateSwitcher_.Register(128, xpWidgetHierarchy_);
			ButtonSet.Up(xpWidgetHierarchy_.widget, ButtonSetGroup.PlayerInfo);
		}

		public void SetXpWidgetValues(int level, int exp, int expMax)
		{
			xpWidgetHierarchy_.levelLabel.text = level.ToString();
			xpWidgetHierarchy_.xpLabel.text = exp.ToString();
			float value = ((expMax <= 0) ? 0f : ((float)exp / (float)expMax));
			xpWidgetHierarchy_.slider.Set(Mathf.Clamp01(value));
		}
	}
}
