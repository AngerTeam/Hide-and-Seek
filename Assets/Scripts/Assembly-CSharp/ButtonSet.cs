using System;
using System.Collections.Generic;
using HudSystem;

public class ButtonSet
{
	private static Dictionary<ButtonSetGroup, bool> groups = Init();

	public static event Action Executed;

	public static event Action<ButtonSetGroup, bool> GroupUpdated;

	public static void ReportExecuted()
	{
		if (ButtonSet.Executed != null)
		{
			ButtonSet.Executed();
		}
	}

	public static void Up(UIWidget widget, ButtonSetGroup group)
	{
		new ButtonSetData(widget, group);
	}

	public static void Up(UIButton button, Action action, ButtonSetGroup group)
	{
		ButtonSetData @object = new ButtonSetData(button, action, group);
		button.disabledColor = button.defaultColor;
		EventDelegate.Set(button.onClick, @object.Handle);
	}

	internal static void EnableGroup(ButtonSetGroup groupId, bool enable)
	{
		groups[groupId] = enable;
		if (ButtonSet.GroupUpdated != null)
		{
			ButtonSet.GroupUpdated(groupId, enable);
		}
	}

	private static Dictionary<ButtonSetGroup, bool> Init()
	{
		Dictionary<ButtonSetGroup, bool> dictionary = new Dictionary<ButtonSetGroup, bool>();
		dictionary.Add(ButtonSetGroup.Undefined, true);
		dictionary.Add(ButtonSetGroup.Slots, true);
		dictionary.Add(ButtonSetGroup.Hud, true);
		dictionary.Add(ButtonSetGroup.InWindow, true);
		dictionary.Add(ButtonSetGroup.PlayerInfo, true);
		return dictionary;
	}
}
