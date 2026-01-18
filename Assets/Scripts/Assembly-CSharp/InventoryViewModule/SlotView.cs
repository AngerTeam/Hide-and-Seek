using System;
using CraftyEngine.Infrastructure;
using InventoryModule;
using NguiTools;
using UnityEngine;

namespace InventoryViewModule
{
	public class SlotView : IDisposable
	{
		private ActivatableGameObject<UILabel> goAmountLabel_;

		private ActivatableGameObject<UISprite> goBackground_;

		private ActivatableGameObject<UISlider> goDurabilitySlider_;

		private ActivatableGameObject<UISprite> goIcon_;

		private ActivatableGameObject<UISprite> goPlaceHolder_;

		private ActivatableGameObject<UISprite> goTempIcon_;

		private ActivatableGameObject<UISprite> goInfinityIcon_;

		private ActivatableGameObject<UILabel> goIndexIcon_;

		private InvetnoryController invetnoryController_;

		private int lastAmount_;

		private int lastIconId_;

		private int lastWear_;

		private NguiManager nguiManager_;

		public bool ghost;

		public UIWidget Container { get; private set; }

		public InventorySlotHierarchy Hierarchy { get; private set; }

		public SlotViewType Type { get; private set; }

		public SlotView(SlotViewType type)
		{
			lastAmount_ = int.MinValue;
			lastIconId_ = int.MinValue;
			lastWear_ = int.MinValue;
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<InvetnoryController>(out invetnoryController_);
			Type = type;
			switch (type)
			{
			case SlotViewType.Normal:
				Build("UiUniSlot");
				break;
			case SlotViewType.IconOnly:
				Build("UiUniSlot");
				Hierarchy.backgroundBorder.gameObject.SetActive(false);
				break;
			case SlotViewType.Trash:
				Build("UIInventoryTrashButton");
				Hierarchy.title.text = Localisations.Get("UI_Inventory_TrashSlotTitle");
				break;
			default:
				Log.Error("Not supported type!");
				break;
			}
			Container = Hierarchy.widget;
		}

		private void Build(string prefab)
		{
			PrefabsManager prefabsManager = SingletonManager.Get<PrefabsManager>();
			Hierarchy = prefabsManager.Instantiate<InventorySlotHierarchy>(prefab);
			goIcon_ = new ActivatableGameObject<UISprite>(Hierarchy.icon);
			goTempIcon_ = new ActivatableGameObject<UISprite>(Hierarchy.tempIcon);
			goInfinityIcon_ = new ActivatableGameObject<UISprite>(Hierarchy.infinityIcon);
			goIndexIcon_ = new ActivatableGameObject<UILabel>(Hierarchy.bindKeyLabel);
			goDurabilitySlider_ = new ActivatableGameObject<UISlider>(Hierarchy.durabilitySlider);
			goPlaceHolder_ = new ActivatableGameObject<UISprite>(Hierarchy.placeHolder);
			goAmountLabel_ = new ActivatableGameObject<UILabel>(Hierarchy.amountLabel);
			goBackground_ = new ActivatableGameObject<UISprite>(Hierarchy.background);
			goPlaceHolder_.SetActive(false);
		}

		public void Dispose()
		{
			if (Hierarchy != null && Hierarchy.gameObject != null)
			{
				UnityEngine.Object.Destroy(Hierarchy.gameObject);
			}
			Hierarchy = null;
		}

		public void ReadItem(ArtikulItem item)
		{
			if (Type == SlotViewType.Trash)
			{
				return;
			}
			if (item == null || item.ArtikulId == 0 || item.Amount == 0)
			{
				Clear();
				return;
			}
			goIcon_.SetActive(true);
			if (lastIconId_ != item.IconId && nguiManager_.SetIconSprite(goIcon_.value, item.IconId.ToString()))
			{
				lastIconId_ = item.IconId;
			}
			float num = ((!ghost) ? 1f : 0.5f);
			if (num != goIcon_.value.alpha)
			{
				goIcon_.value.alpha = num;
			}
			if (Type == SlotViewType.IconOnly)
			{
				return;
			}
			goTempIcon_.SetActive(item.IsTemp);
			goInfinityIcon_.SetActive(item.infiniteView);
			goDurabilitySlider_.SetActive(item.Wearable);
			if (item.Wearable && lastWear_ != item.Wear)
			{
				lastWear_ = item.Wear;
				if (item.Wear == 0)
				{
					goDurabilitySlider_.value.value = 1f;
				}
				else
				{
					goDurabilitySlider_.value.value = 1f - (float)item.Wear / (float)item.WearMax;
				}
			}
			goBackground_.SetActive(true);
			invetnoryController_.SetBackgroundSprite(goBackground_.value, item.Entry);
			if (item.AmountMax <= 1 || item.infiniteLogic)
			{
				goAmountLabel_.SetActive(false);
				return;
			}
			goAmountLabel_.SetActive(true);
			if (lastAmount_ != item.Amount)
			{
				lastAmount_ = item.Amount;
				goAmountLabel_.value.text = item.Amount.ToString();
			}
		}

		public void SetBindKey(string key)
		{
			Hierarchy.bindKeyLabel.gameObject.SetActive(true);
			Hierarchy.bindKeyLabel.text = key;
		}

		private void Clear()
		{
			goTempIcon_.SetActive(false);
			goInfinityIcon_.SetActive(false);
			goIndexIcon_.SetActive(false);
			goAmountLabel_.SetActive(false);
			goIcon_.SetActive(false);
			goDurabilitySlider_.SetActive(false);
			goBackground_.SetActive(false);
		}
	}
}
