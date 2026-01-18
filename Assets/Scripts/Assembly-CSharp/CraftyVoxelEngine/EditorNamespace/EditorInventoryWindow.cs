using System.Collections.Generic;
using InventoryModule;
using InventoryViewModule;

namespace CraftyVoxelEngine.Editor
{
	public class EditorInventoryWindow : InventoryWindow
	{
		public EditorInventoryWindow()
		{
			base.HudState = 67117057;
			VoxelInventoryModel voxelInventoryModel = SingletonManager.Get<VoxelInventoryModel>();
			for (int i = 0; i < voxelInventoryModel.Groups.Count; i++)
			{
				VoxelInventoryModel.Group group = voxelInventoryModel.Groups[i];
				List<SlotModel> slots = voxelInventoryModel.Slots[group.entry.id];
				EditorSubwindow gameSubwindow = new EditorSubwindow(slots);
				base.tabs.AddSubWindow(gameSubwindow, i, group.entry.title);
			}
			base.tabs.ActivateTab(0);
		}

		public override void Dispose()
		{
			foreach (SubWindow value in base.tabs.Windows.Values)
			{
				EditorSubwindow editorSubwindow = (EditorSubwindow)value.window;
				editorSubwindow.Dispose();
			}
			base.Dispose();
		}
	}
}
