using CraftyVoxelEngine.FX;

namespace CraftyVoxelEngine
{
	public class VoxelView
	{
		public VoxelCracks CracksView { get; private set; }

		public VoxelView()
		{
			CracksView = new VoxelCracks();
		}

		public void SetCracks(VoxelKey GlobalKey, int type = 0, byte rotation = 0)
		{
			CracksView.Set(GlobalKey, type, rotation);
		}

		public void SetCracks(VoxelInteraction interaction)
		{
			CracksView.Set(interaction.model.globalKey, interaction.model.data.ModelID, interaction.model.rotation);
		}

		public void SetCracks(VoxelData data, VoxelKey globalkey, byte rotor)
		{
			CracksView.Set(globalkey, data.ModelID, rotor);
		}

		public void SetProgress(float progress = 0f)
		{
			if (CracksView != null && CracksView.SharedMaterial != null)
			{
				CracksView.SharedMaterial.SetFloat("_Step", 10f - progress * 9.99f);
			}
		}

		public void Hide()
		{
			CracksView.Hide();
		}
	}
}
