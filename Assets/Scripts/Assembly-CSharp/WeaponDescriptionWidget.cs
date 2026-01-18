using System;
using System.Globalization;
using CraftyEngine.Infrastructure;
using NguiTools;
using ShopModule;
using UnityEngine;

public class WeaponDescriptionWidget
{
	private WeaponDescriptionWidgetHierarchy hierarchy_;

	public WeaponDescriptionWidget(Transform parent, bool compact = false)
	{
		PrefabsManagerNGUI singlton;
		SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
		singlton.Load("ShopModule");
		hierarchy_ = singlton.InstantiateNGUIIn<WeaponDescriptionWidgetHierarchy>("UIWeaponDescriptionWidget", parent.gameObject);
		hierarchy_.widget.SetAnchor(parent.gameObject, 0, 0, 0, 0);
		if (compact)
		{
			hierarchy_.StatsTable.columns = 2;
			UnityEvent.OnNextUpdate(delegate
			{
				hierarchy_.StatsTable.Reposition();
			});
			hierarchy_.SideDescriptionLabel.gameObject.SetActive(false);
			hierarchy_.SideRestrictedLabel.gameObject.SetActive(false);
		}
		hierarchy_.DamageFieldLabel.text = Localisations.Get("UI_Damage");
		hierarchy_.RangeFieldLabel.text = Localisations.Get("UI_Range");
		hierarchy_.SpeedFieldLabel.text = Localisations.Get("ui_Attack_Speed");
		hierarchy_.MoveSpeedFieldLabel.text = Localisations.Get("UI_MovementSpeed");
	}

	public void SetMainDescription(string text)
	{
		hierarchy_.MainDescriptionLabel.text = text;
	}

	public void SwitchDescription(bool on)
	{
		hierarchy_.WeaponDescriptionWidget.gameObject.SetActive(on);
		hierarchy_.MainDescriptionWidget.gameObject.SetActive(!on);
	}

	public void ItemSelect(ShopItemsEntries entry)
	{
		string description = entry.description;
		int num = (int)(10f / entry.artikul.cooldown);
		hierarchy_.DamageValueLabel.text = entry.artikul.damage.ToString();
		hierarchy_.RangeValueLabel.text = entry.artikul.weapon_range.ToString(CultureInfo.InvariantCulture);
		hierarchy_.SpeedValueLabel.text = num.ToString(CultureInfo.InvariantCulture);
		if (entry.artikul.slowdown_factor == 0f)
		{
			hierarchy_.MoveSpeedContainer.gameObject.SetActive(false);
		}
		else
		{
			hierarchy_.MoveSpeedContainer.gameObject.SetActive(true);
			int num2 = Math.Abs(Convert.ToInt32(entry.artikul.slowdown_factor * 100f));
			if (entry.artikul.slowdown_factor > 0f)
			{
				hierarchy_.MoveSpeedValueLabel.text = string.Format("-{0}", num2);
			}
			else
			{
				hierarchy_.MoveSpeedValueLabel.text = string.Format("+{0}", num2);
			}
		}
		hierarchy_.SideDescriptionLabel.text = description;
		hierarchy_.MainDescriptionLabel.text = description;
		UnityEvent.OnNextUpdate(delegate
		{
			hierarchy_.StatsTable.Reposition();
		});
	}

	public void ItemClear()
	{
		hierarchy_.MainDescriptionLabel.text = string.Empty;
		hierarchy_.DamageValueLabel.text = string.Empty;
		hierarchy_.RangeValueLabel.text = string.Empty;
		hierarchy_.SpeedValueLabel.text = string.Empty;
		hierarchy_.MoveSpeedContainer.gameObject.SetActive(false);
		hierarchy_.SideRestrictedLabel.gameObject.SetActive(false);
		hierarchy_.MainRestrictedLabel.gameObject.SetActive(false);
		UnityEvent.OnNextUpdate(delegate
		{
			hierarchy_.StatsTable.Reposition();
		});
	}

	public void SetRestricted(string text, Color color, bool isActive)
	{
		hierarchy_.SideRestrictedLabel.text = text;
		hierarchy_.MainRestrictedLabel.text = text;
		hierarchy_.SideRestrictedLabel.color = color;
		hierarchy_.MainRestrictedLabel.color = color;
		hierarchy_.SideRestrictedLabel.gameObject.SetActive(isActive);
		hierarchy_.MainRestrictedLabel.gameObject.SetActive(isActive);
	}
}
