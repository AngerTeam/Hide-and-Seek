using UnityEngine;

public class UIMainMenuHierarchy : MonoBehaviour
{
	public UIGrid lineGrid;

	public UIWidget bottomWidget;

	public EnvelopContent envelopContent;

	[Space(10f)]
	public UIToggle toggleMusic;

	public UIToggle toggleSound;

	public UIButton buttonLanguage;

	[Space(10f)]
	public UISprite languageFlag;
}
