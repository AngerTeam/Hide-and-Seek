using CraftyGameEngine.Player;
using PlayerModule;
using PlayerModule.MyPlayer;
using PlayerModule.Playmate;
using UnityEngine;

public class FriendModelHolder : MonoBehaviour
{
	public UITexture Holder;

	public UIWidget RollerHolder;

	private UiRoller roller_;

	private MyPlayerStatsModel playerManager_;

	private ActorHolderUI3D actor_;

	private PlayerStatsModel stats_;

	private PlaymateEntity player_;

	public void SetSkin(int skinId)
	{
		if (stats_ != null)
		{
			player_.Controller.BodyViewUpdated += HandleSkinChanged;
			roller_.Widget.gameObject.SetActive(true);
			stats_.SkinId = skinId;
		}
	}

	private void HandleSkinChanged()
	{
		player_.Controller.BodyViewUpdated -= HandleSkinChanged;
		roller_.Widget.gameObject.SetActive(false);
	}

	public void ShowActor()
	{
		if (actor_ != null)
		{
			actor_.SwitchActive(true);
		}
	}

	public void HideActor()
	{
		if (actor_ != null)
		{
			actor_.SwitchActive(false);
		}
	}

	public void CreateActor()
	{
		if (actor_ == null)
		{
			SingletonManager.Get<MyPlayerStatsModel>(out playerManager_);
			stats_ = PlayerStatsModel.Clone(playerManager_.stats);
			stats_.IsDummy = true;
			stats_.SetPosition(Vector3.zero, Vector3.zero);
			actor_ = new ActorHolderUI3D();
			roller_ = new UiRoller(RollerHolder);
			actor_.AddActor(stats_, Holder.transform, true, 0.75f, -0.5f, false);
			actor_.SwitchActive(true);
			player_ = actor_.PlaymateEntity;
		}
	}

	public void DisposeActor()
	{
		roller_.Dispose();
		actor_.Dispose();
		stats_.Dispose();
		player_.Dispose();
	}
}
