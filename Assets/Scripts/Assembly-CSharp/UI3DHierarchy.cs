using System.Runtime.InteropServices;
using UnityEngine;

public class UI3DHierarchy : MonoBehaviour
{
	public static bool Perspective;

	public Camera ui3dCamera;

	public Transform rootPersp;

	public Transform rootOrtho;

	[Space(10f)]
	public UIWidget Ancor;

	public Transform AncorLB;

	public Transform AncorRT;

	public Transform root
	{
		get
		{
			return (!Perspective) ? rootOrtho : rootPersp;
		}
	}

	public void UpdateAncors([Optional] Vector3 extraScale)
	{
		Vector3 vector = (new Vector3(Ancor.localSize.x, Ancor.localSize.y, 0f) + extraScale) / 2f;
		vector.z = 0f;
		AncorLB.localPosition = -vector;
		AncorRT.localPosition = vector;
	}
}
