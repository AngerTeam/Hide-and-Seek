using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using MoneyModule;
using NguiTools;
using PlayerModule.MyPlayer;
using UnityEngine;
using WindowsModule;

public class MoneyTypesWindow : GameWindow
{
	private readonly MyPlayerStatsModel myPlayerStatsModel_;

	private readonly MoneyTypesWindowHierarchy hierarchy_;

	private readonly List<MoneyTypesWindowRowHierarchy> rows = new List<MoneyTypesWindowRowHierarchy>();

	public MoneyTypesWindow()
	{
		SingletonManager.TryGet<MyPlayerStatsModel>(out myPlayerStatsModel_);
		prefabsManager.Load("MoneyPrefabsHolder");
		hierarchy_ = prefabsManager.InstantiateNGUIIn<MoneyTypesWindowHierarchy>("UIMoneyTypesWindow", nguiManager.UiRoot.gameObject);
		SetContent(hierarchy_.transform, true, true, false, false, true);
		base.ViewChanged += OnViewChanged;
	}

	private void OnViewChanged(object sender, BoolEventArguments e)
	{
		if (Visible)
		{
			Build();
		}
	}

	private void Build()
	{
		if (MoneyTypesContentMap.MoneyTypes == null)
		{
			return;
		}
		foreach (MoneyTypesWindowRowHierarchy row in rows)
		{
			Object.Destroy(row.gameObject);
		}
		rows.Clear();
		foreach (MoneyTypesEntries value in MoneyTypesContentMap.MoneyTypes.Values)
		{
			NguiFileManager nguiFileManager = SingletonManager.Get<NguiFileManager>();
			MoneyTypesWindowRowHierarchy moneyTypesWindowRowHierarchy = Object.Instantiate(hierarchy_.rowTemplate);
			moneyTypesWindowRowHierarchy.transform.SetParent(hierarchy_.rowTemplate.transform.parent, false);
			moneyTypesWindowRowHierarchy.NameLabel.text = Localisations.Get(value.title);
			moneyTypesWindowRowHierarchy.AmountLabel.text = myPlayerStatsModel_.money.GetMoneyAmount(value.id).ToString();
			moneyTypesWindowRowHierarchy.gameObject.SetActive(true);
			rows.Add(moneyTypesWindowRowHierarchy);
			if (!string.IsNullOrEmpty(value.icon))
			{
				nguiFileManager.SetUiTexture(moneyTypesWindowRowHierarchy.Texture, value.GetFullIconPath());
			}
		}
		ResetScroll();
	}

	private void ResetScroll()
	{
		hierarchy_.ContentsGrid.repositionNow = true;
	}
}
