using UnityEngine;

public class PlayerInfoWindowHierarchy : MonoBehaviour
{
	public GameObject instanceContainer;

	public UIScrollView ScrollView;

	public UIItemsGrid Grid;

	public UITable Table;

	[Space(10f)]
	public GameObject IcoContainer;

	public GameObject InfoContainer;

	[Space(10f)]
	public UIButtonHolder Join;

	public UIButtonHolder AddFriend;

	public UIButtonHolder DeleteFriend;

	public UIButtonHolder Accept;

	public UIButtonHolder Decline;

	[Space(10f)]
	public UITable NameTable;

	public UILabel NameLabel;

	public UILabel RequestLabel;

	public UILabel LevelLabel;

	public UILabel StatusLabel;

	public UILabel InstanceLabel;

	public UILabel MapsLabel;

	public UILabel MapsCountLabel;

	public UILabel KillsLabel;

	public UILabel KillsCountLabel;

	public UILabel DateLabel;

	public UILabel DateDataLabel;

	public UILabel AboutLabel;

	public UILabel DescriptionLabel;

	public UILabel[] FriendsLabels;

	public UILabel[] FriendsCountLabels;
}
