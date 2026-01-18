using UnityEngine;

namespace WindowsModule
{
	public class GameWindowMemento
	{
		public int[] initialDepths;

		public Vector3 position;

		public Vector3 scale;

		public float alpha;

		public void Read(GameWindow source)
		{
			if (initialDepths == null || initialDepths.Length != source.Widgets.Length)
			{
				initialDepths = new int[source.Widgets.Length];
			}
			for (int i = 0; i < source.Widgets.Length; i++)
			{
				initialDepths[i] = source.Widgets[i].depth;
			}
			position = source.Hierarchy.panel.transform.localPosition;
			scale = source.Hierarchy.panel.transform.localScale;
			alpha = source.Hierarchy.panel.alpha;
		}
	}
}
