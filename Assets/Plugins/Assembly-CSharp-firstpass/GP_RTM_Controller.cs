using System;
using System.Collections.Generic;
using SA.Common.Pattern;

public class GP_RTM_Controller : iRTM_Matchmaker
{
	private List<UM_RTM_Invite> _Invitations = new List<UM_RTM_Invite>();

	private UM_RTM_Room _CurrentRoom = new UM_RTM_Room();

	public List<UM_RTM_Invite> Invitations
	{
		get
		{
			return _Invitations;
		}
	}

	public UM_RTM_Room CurrentRoom
	{
		get
		{
			return _CurrentRoom;
		}
	}

	public event Action<UM_RTM_Invite> InvitationReceived = delegate
	{
	};

	public event Action<UM_RTM_Invite> InvitationAccepted = delegate
	{
	};

	public event Action<string> InvitationDeclined = delegate
	{
	};

	public event Action<UM_RTM_RoomCreatedResult> RoomCreated = delegate
	{
	};

	public event Action RoomUpdated = delegate
	{
	};

	public event Action<string, byte[]> MatchDataReceived = delegate
	{
	};

	public GP_RTM_Controller()
	{
		GooglePlayRTM.ActionInvitationReceived = (Action<GP_Invite>)Delegate.Combine(GooglePlayRTM.ActionInvitationReceived, new Action<GP_Invite>(HandleActionInvitationReceived));
		GooglePlayRTM.ActionInvitationRemoved = (Action<string>)Delegate.Combine(GooglePlayRTM.ActionInvitationRemoved, new Action<string>(HandleActionInvitationRemoved));
		GooglePlayRTM.ActionInvitationAccepted = (Action<GP_Invite>)Delegate.Combine(GooglePlayRTM.ActionInvitationAccepted, new Action<GP_Invite>(HandleActionInvitationAccepted));
		GooglePlayRTM.ActionRoomCreated = (Action<GP_GamesStatusCodes>)Delegate.Combine(GooglePlayRTM.ActionRoomCreated, new Action<GP_GamesStatusCodes>(HandleActionRoomCreated));
		GooglePlayRTM.ActionDataRecieved = (Action<GP_RTM_Network_Package>)Delegate.Combine(GooglePlayRTM.ActionDataRecieved, new Action<GP_RTM_Network_Package>(HandleActionMatchDataReceived));
		GooglePlayRTM.ActionRoomUpdated = (Action<GP_RTM_Room>)Delegate.Combine(GooglePlayRTM.ActionRoomUpdated, new Action<GP_RTM_Room>(HandleActionRoomUpdated));
		GooglePlayConnection.ActionPlayerConnected += HandleActionPlayerConnected;
	}

	public void OpenInvitationUI(int minPlayers, int maxPlayers)
	{
		Singleton<GooglePlayRTM>.Instance.OpenInvitationBoxUI(minPlayers, maxPlayers);
	}

	public void AcceptInvite(UM_RTM_Invite invite)
	{
		Singleton<GooglePlayRTM>.Instance.AcceptInvitation(invite.Id);
	}

	public void DeclineInvite(UM_RTM_Invite invite)
	{
		Singleton<GooglePlayRTM>.Instance.DeclineInvitation(invite.Id);
	}

	public void FindMatch(int minPlayers, int maxPlayers)
	{
		Singleton<GooglePlayRTM>.Instance.FindMatch(minPlayers, maxPlayers);
	}

	public void SendDataToAll(byte[] data, UM_RTM_PackageType type)
	{
		Singleton<GooglePlayRTM>.Instance.SendDataToAll(data, type.GetGPPackageType());
	}

	public void SendDataToPlayer(byte[] data, UM_RTM_PackageType type, params string[] receivers)
	{
		Singleton<GooglePlayRTM>.Instance.sendDataToPlayers(data, type.GetGPPackageType(), receivers);
	}

	public void LeaveMatch()
	{
		Singleton<GooglePlayRTM>.Instance.LeaveRoom();
	}

	private void HandleActionRoomUpdated(GP_RTM_Room room)
	{
		_CurrentRoom = new UM_RTM_Room(room);
		this.RoomUpdated();
	}

	private void HandleActionMatchDataReceived(GP_RTM_Network_Package package)
	{
		this.MatchDataReceived(package.participantId, package.buffer);
	}

	private void HandleActionRoomCreated(GP_GamesStatusCodes status)
	{
		UM_RTM_RoomCreatedResult obj = new UM_RTM_RoomCreatedResult(status);
		_CurrentRoom = new UM_RTM_Room(Singleton<GooglePlayRTM>.Instance.currentRoom);
		this.RoomCreated(obj);
	}

	private void HandleActionPlayerConnected()
	{
		Singleton<GooglePlayInvitationManager>.Instance.RegisterInvitationListener();
	}

	private void HandleActionInvitationReceived(GP_Invite invite)
	{
		UM_RTM_Invite uM_RTM_Invite = new UM_RTM_Invite(invite);
		_Invitations.Add(uM_RTM_Invite);
		this.InvitationReceived(uM_RTM_Invite);
	}

	private void HandleActionInvitationRemoved(string id)
	{
		RemoveInvitation(id);
		this.InvitationDeclined(id);
	}

	private void HandleActionInvitationAccepted(GP_Invite invite)
	{
		if (invite.InvitationType == GP_InvitationType.INVITATION_TYPE_REAL_TIME)
		{
			UM_RTM_Invite invite2 = null;
			if (!TryGetInvitation(invite.Id, out invite2))
			{
				invite2 = new UM_RTM_Invite(invite);
				_Invitations.Add(invite2);
			}
			this.InvitationAccepted(invite2);
		}
	}

	private bool TryGetInvitation(string id, out UM_RTM_Invite invite)
	{
		invite = null;
		foreach (UM_RTM_Invite invitation in _Invitations)
		{
			if (invitation.Id.Equals(id))
			{
				invite = invitation;
				return true;
			}
		}
		return false;
	}

	private void RemoveInvitation(string id)
	{
		foreach (UM_RTM_Invite invitation in _Invitations)
		{
			if (invitation.Id.Equals(id))
			{
				_Invitations.Remove(invitation);
				break;
			}
		}
	}
}
