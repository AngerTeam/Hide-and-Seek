using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ProFlare : MonoBehaviour
{
	public ProFlareAtlas _Atlas;

	public ProFlareBatch[] FlareBatches = new ProFlareBatch[0];

	public bool EditingAtlas;

	public bool isVisible = true;

	public List<ProFlareElement> Elements = new List<ProFlareElement>();

	public Transform thisTransform;

	public Vector3 LensPosition;

	public bool EditGlobals;

	public float GlobalScale = 100f;

	public bool MultiplyScaleByTransformScale;

	public float GlobalBrightness = 1f;

	public Color GlobalTintColor = Color.white;

	public bool useMaxDistance = true;

	public bool useDistanceScale = true;

	public bool useDistanceFade = true;

	public float GlobalMaxDistance = 150f;

	public bool UseAngleLimit;

	public float maxAngle = 90f;

	public bool UseAngleScale;

	public bool UseAngleBrightness = true;

	public bool UseAngleCurve;

	public AnimationCurve AngleCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f));

	public LayerMask mask = 1;

	public bool RaycastPhysics;

	public bool Occluded;

	public float OccludeScale = 1f;

	public float OffScreenFadeDist = 0.2f;

	public bool useDynamicEdgeBoost;

	public float DynamicEdgeBoost = 1f;

	public float DynamicEdgeBrightness = 0.1f;

	public float DynamicEdgeRange = 0.3f;

	public float DynamicEdgeBias = -0.1f;

	public AnimationCurve DynamicEdgeCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public bool useDynamicCenterBoost;

	public float DynamicCenterBoost = 1f;

	public float DynamicCenterBrightness = 0.2f;

	public float DynamicCenterRange = 0.3f;

	public float DynamicCenterBias;

	public bool neverCull;

	private bool Initialised;

	public bool DisabledPlayMode;

	private void Awake()
	{
		DisabledPlayMode = false;
		Initialised = false;
		thisTransform = base.transform;
	}

	private void Start()
	{
		thisTransform = base.transform;
		if (_Atlas != null && FlareBatches.Length == 0)
		{
			PopulateFlareBatches();
		}
		if (!Initialised)
		{
			Init();
		}
		for (int i = 0; i < Elements.Count; i++)
		{
			Elements[i].flareAtlas = _Atlas;
			Elements[i].flare = this;
		}
	}

	private void PopulateFlareBatches()
	{
		ProFlareBatch[] array = Object.FindObjectsOfType(typeof(ProFlareBatch)) as ProFlareBatch[];
		int num = 0;
		ProFlareBatch[] array2 = array;
		foreach (ProFlareBatch proFlareBatch in array2)
		{
			if (proFlareBatch._atlas == _Atlas)
			{
				num++;
			}
		}
		FlareBatches = new ProFlareBatch[num];
		int num2 = 0;
		ProFlareBatch[] array3 = array;
		foreach (ProFlareBatch proFlareBatch2 in array3)
		{
			if (proFlareBatch2._atlas == _Atlas)
			{
				FlareBatches[num2] = proFlareBatch2;
				num2++;
			}
		}
	}

	private void Init()
	{
		if (thisTransform == null)
		{
			thisTransform = base.transform;
		}
		if (_Atlas == null)
		{
			return;
		}
		PopulateFlareBatches();
		for (int i = 0; i < Elements.Count; i++)
		{
			Elements[i].flareAtlas = _Atlas;
		}
		for (int j = 0; j < FlareBatches.Length; j++)
		{
			if (FlareBatches[j] != null && FlareBatches[j]._atlas == _Atlas)
			{
				FlareBatches[j].AddFlare(this);
			}
		}
		Initialised = true;
	}

	public void ReInitialise()
	{
		Initialised = false;
		Init();
	}

	private void OnEnable()
	{
		if (Application.isPlaying && DisabledPlayMode)
		{
			DisabledPlayMode = false;
			return;
		}
		if ((bool)_Atlas)
		{
			for (int i = 0; i < FlareBatches.Length; i++)
			{
				if (FlareBatches[i] != null)
				{
					FlareBatches[i].dirty = true;
				}
				else
				{
					Initialised = false;
				}
			}
		}
		Init();
	}

	private void OnDisable()
	{
		if (Application.isPlaying)
		{
			DisabledPlayMode = true;
			return;
		}
		for (int i = 0; i < FlareBatches.Length; i++)
		{
			if (FlareBatches[i] != null)
			{
				FlareBatches[i].RemoveFlare(this);
				FlareBatches[i].dirty = true;
			}
			else
			{
				Initialised = false;
			}
		}
	}

	private void OnDestroy()
	{
		for (int i = 0; i < FlareBatches.Length; i++)
		{
			if (FlareBatches[i] != null)
			{
				FlareBatches[i].RemoveFlare(this);
				FlareBatches[i].dirty = true;
			}
			else
			{
				Initialised = false;
			}
		}
	}

	private void Update()
	{
		if (!Initialised)
		{
			Init();
		}
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = GlobalTintColor;
		Gizmos.DrawSphere(base.transform.position, 0.1f);
	}
}
