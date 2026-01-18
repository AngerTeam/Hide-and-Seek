using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(MeshRenderer))]
[RequireComponent(typeof(MeshFilter))]
public class ProFlareBatch : MonoBehaviour
{
	public enum Mode
	{
		Standard = 0,
		SingleCamera = 1,
		VR = 2
	}

	public bool debugMessages = true;

	public Mode mode;

	public ProFlareAtlas _atlas;

	public List<FlareData> FlaresList = new List<FlareData>();

	public List<ProFlareElement> FlareElements = new List<ProFlareElement>();

	public ProFlareElement[] FlareElementsArray;

	public Camera GameCamera;

	public Transform GameCameraTrans;

	public Camera FlareCamera;

	public Transform FlareCameraTrans;

	public MeshFilter meshFilter;

	public Transform thisTransform;

	public MeshRenderer meshRender;

	public float zPos;

	private Mesh bufferMesh;

	private Mesh meshA;

	private Mesh meshB;

	private bool PingPong;

	public Material mat;

	private Vector3[] vertices;

	private Vector2[] uv;

	private Color32[] colors;

	private int[] triangles;

	public FlareOcclusion[] FlareOcclusionData;

	public bool useBrightnessThreshold = true;

	public int BrightnessThreshold = 1;

	public bool overdrawDebug;

	public bool dirty = true;

	public bool useCulling = true;

	public int cullFlaresAfterTime = 5;

	public int cullFlaresAfterCount = 5;

	public bool culledFlaresNowVisiable;

	private float reshowCulledFlaresTimer;

	public float reshowCulledFlaresAfter = 0.3f;

	public Transform helperTransform;

	public bool showAllConnectedFlares;

	public bool VR_Mode;

	public float VR_Depth = 0.2f;

	public bool SingleCamera_Mode;

	private Vector3[] verts;

	private Vector2 _scale;

	private Color32 _color;

	private float PI_Div180;

	private float Div180_PI;

	private int visibleFlares;

	private void CreateMat()
	{
		mat = new Material(Shader.Find("ProFlares/Textured Flare Shader"));
		meshRender.material = mat;
		if ((bool)_atlas && (bool)_atlas.texture)
		{
			mat.mainTexture = _atlas.texture;
		}
	}

	private void CreateHelperTransform()
	{
		GameObject gameObject = new GameObject("_HelperTransform");
		helperTransform = gameObject.transform;
		helperTransform.parent = base.transform;
		helperTransform.localScale = Vector3.one;
		helperTransform.localPosition = Vector3.zero;
	}

	private void ReBuildGeometry()
	{
		FlareElements.Clear();
		int num = 0;
		bool flag = false;
		for (int i = 0; i < FlaresList.Count; i++)
		{
			if (FlaresList[i].flare == null)
			{
				flag = true;
				break;
			}
			for (int j = 0; j < FlaresList[i].flare.Elements.Count; j++)
			{
				if (FlaresList[i].occlusion._CullingState == FlareOcclusion.CullingState.CanCull)
				{
					FlaresList[i].occlusion._CullingState = FlareOcclusion.CullingState.Culled;
					FlaresList[i].occlusion.cullFader = 0f;
				}
				if (FlaresList[i].occlusion._CullingState != FlareOcclusion.CullingState.Culled)
				{
					num++;
				}
			}
		}
		FlareElementsArray = new ProFlareElement[num];
		num = 0;
		if (!flag)
		{
			for (int k = 0; k < FlaresList.Count; k++)
			{
				for (int l = 0; l < FlaresList[k].flare.Elements.Count; l++)
				{
					if (FlaresList[k].occlusion._CullingState != FlareOcclusion.CullingState.Culled)
					{
						FlareElementsArray[num] = FlaresList[k].flare.Elements[l];
						num++;
					}
				}
			}
		}
		if (flag)
		{
			ForceRefresh();
			ReBuildGeometry();
			flag = false;
		}
		meshA = null;
		meshB = null;
		bufferMesh = null;
		SetupMeshes();
		dirty = false;
	}

	private void SetupMeshes()
	{
		if (_atlas == null || FlareElementsArray == null)
		{
			return;
		}
		meshA = new Mesh();
		meshB = new Mesh();
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		for (int i = 0; i < FlareElementsArray.Length; i++)
		{
			switch (FlareElementsArray[i].type)
			{
			case ProFlareElement.Type.Single:
				num += 4;
				num2 += 4;
				num3 += 4;
				num4 += 6;
				break;
			case ProFlareElement.Type.Multi:
			{
				int count = FlareElementsArray[i].subElements.Count;
				num += 4 * count;
				num2 += 4 * count;
				num3 += 4 * count;
				num4 += 6 * count;
				break;
			}
			}
		}
		vertices = new Vector3[num];
		uv = new Vector2[num2];
		colors = new Color32[num3];
		triangles = new int[num4];
		for (int j = 0; j < vertices.Length / 4; j++)
		{
			int num5 = j * 4;
			vertices[0 + num5] = new Vector3(1f, 1f, 0f);
			vertices[1 + num5] = new Vector3(1f, -1f, 0f);
			vertices[2 + num5] = new Vector3(-1f, 1f, 0f);
			vertices[3 + num5] = new Vector3(-1f, -1f, 0f);
		}
		int num6 = 0;
		for (int k = 0; k < FlareElementsArray.Length; k++)
		{
			switch (FlareElementsArray[k].type)
			{
			case ProFlareElement.Type.Single:
			{
				int num8 = num6 * 4;
				Rect uV2 = _atlas.elementsList[FlareElementsArray[k].elementTextureID].UV;
				uv[0 + num8] = new Vector2(uV2.xMax, uV2.yMax);
				uv[1 + num8] = new Vector2(uV2.xMax, uV2.yMin);
				uv[2 + num8] = new Vector2(uV2.xMin, uV2.yMax);
				uv[3 + num8] = new Vector2(uV2.xMin, uV2.yMin);
				num6++;
				break;
			}
			case ProFlareElement.Type.Multi:
			{
				for (int l = 0; l < FlareElementsArray[k].subElements.Count; l++)
				{
					int num7 = (num6 + l) * 4;
					Rect uV = _atlas.elementsList[FlareElementsArray[k].elementTextureID].UV;
					uv[0 + num7] = new Vector2(uV.xMax, uV.yMax);
					uv[1 + num7] = new Vector2(uV.xMax, uV.yMin);
					uv[2 + num7] = new Vector2(uV.xMin, uV.yMax);
					uv[3 + num7] = new Vector2(uV.xMin, uV.yMin);
				}
				num6 += FlareElementsArray[k].subElements.Count;
				break;
			}
			}
		}
		Color32 color = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
		for (int m = 0; m < colors.Length / 4; m++)
		{
			int num9 = m * 4;
			colors[0 + num9] = color;
			colors[1 + num9] = color;
			colors[2 + num9] = color;
			colors[3 + num9] = color;
		}
		for (int n = 0; n < triangles.Length / 6; n++)
		{
			int num10 = n * 4;
			int num11 = n * 6;
			triangles[0 + num11] = 0 + num10;
			triangles[1 + num11] = 1 + num10;
			triangles[2 + num11] = 2 + num10;
			triangles[3 + num11] = 2 + num10;
			triangles[4 + num11] = 1 + num10;
			triangles[5 + num11] = 3 + num10;
		}
		meshA.vertices = vertices;
		meshA.uv = uv;
		meshA.triangles = triangles;
		meshA.colors32 = colors;
		meshA.bounds = new Bounds(Vector3.zero, Vector3.one * 1000f);
		meshB.vertices = vertices;
		meshB.uv = uv;
		meshB.triangles = triangles;
		meshB.colors32 = colors;
		meshB.bounds = new Bounds(Vector3.zero, Vector3.one * 1000f);
	}

	private void UpdateGeometry()
	{
		if (GameCamera == null)
		{
			meshRender.enabled = false;
			return;
		}
		meshRender.enabled = true;
		visibleFlares = 0;
		int num = 0;
		for (int i = 0; i < FlaresList.Count; i++)
		{
			ProFlare flare = FlaresList[i].flare;
			FlareOcclusion occlusion = FlaresList[i].occlusion;
			if (flare == null)
			{
				continue;
			}
			flare.LensPosition = GameCamera.WorldToViewportPoint(flare.thisTransform.position);
			Vector3 lensPosition = flare.LensPosition;
			bool flag = (flare.isVisible = lensPosition.z > 0f && lensPosition.x + flare.OffScreenFadeDist > 0f && lensPosition.x - flare.OffScreenFadeDist < 1f && lensPosition.y + flare.OffScreenFadeDist > 0f && lensPosition.y - flare.OffScreenFadeDist < 1f);
			float num2 = 1f;
			if (!(lensPosition.x > 0f) || !(lensPosition.x < 1f) || !(lensPosition.y > 0f) || !(lensPosition.y < 1f))
			{
				float num3 = 1f / flare.OffScreenFadeDist;
				float a = 0f;
				float b = 0f;
				if (!(lensPosition.x > 0f) || !(lensPosition.x < 1f))
				{
					a = ((!(lensPosition.x > 0.5f)) ? Mathf.Abs(lensPosition.x) : (lensPosition.x - 1f));
				}
				if (!(lensPosition.y > 0f) || !(lensPosition.y < 1f))
				{
					b = ((!(lensPosition.y > 0.5f)) ? Mathf.Abs(lensPosition.y) : (lensPosition.y - 1f));
				}
				num2 = Mathf.Clamp01(num2 - Mathf.Max(a, b) * num3);
			}
			float num4 = 0f;
			if (lensPosition.x > 0.5f - flare.DynamicCenterRange && lensPosition.x < 0.5f + flare.DynamicCenterRange && lensPosition.y > 0.5f - flare.DynamicCenterRange && lensPosition.y < 0.5f + flare.DynamicCenterRange && flare.DynamicCenterRange > 0f)
			{
				float num5 = 1f / flare.DynamicCenterRange;
				num4 = 1f - Mathf.Max(Mathf.Abs(lensPosition.x - 0.5f), Mathf.Abs(lensPosition.y - 0.5f)) * num5;
			}
			float time = 0f;
			bool flag2 = lensPosition.x > 0f + flare.DynamicEdgeBias + flare.DynamicEdgeRange && lensPosition.x < 1f - flare.DynamicEdgeBias - flare.DynamicEdgeRange && lensPosition.y > 0f + flare.DynamicEdgeBias + flare.DynamicEdgeRange && lensPosition.y < 1f - flare.DynamicEdgeBias - flare.DynamicEdgeRange;
			bool flag3 = lensPosition.x + flare.DynamicEdgeRange > 0f + flare.DynamicEdgeBias && lensPosition.x - flare.DynamicEdgeRange < 1f - flare.DynamicEdgeBias && lensPosition.y + flare.DynamicEdgeRange > 0f + flare.DynamicEdgeBias && lensPosition.y - flare.DynamicEdgeRange < 1f - flare.DynamicEdgeBias;
			if (!flag2 && flag3)
			{
				float num6 = 1f / flare.DynamicEdgeRange;
				float a2 = 0f;
				float b2 = 0f;
				bool flag4 = lensPosition.x > 0f + flare.DynamicEdgeBias + flare.DynamicEdgeRange && lensPosition.x < 1f - flare.DynamicEdgeBias - flare.DynamicEdgeRange;
				bool flag5 = lensPosition.x + flare.DynamicEdgeRange > 0f + flare.DynamicEdgeBias && lensPosition.x - flare.DynamicEdgeRange < 1f - flare.DynamicEdgeBias;
				bool flag6 = lensPosition.y > 0f + flare.DynamicEdgeBias + flare.DynamicEdgeRange && lensPosition.y < 1f - flare.DynamicEdgeBias - flare.DynamicEdgeRange;
				bool flag7 = lensPosition.y + flare.DynamicEdgeRange > 0f + flare.DynamicEdgeBias && lensPosition.y - flare.DynamicEdgeRange < 1f - flare.DynamicEdgeBias;
				if (!flag4 && flag5)
				{
					a2 = ((!(lensPosition.x > 0.5f)) ? Mathf.Abs(lensPosition.x - flare.DynamicEdgeBias - flare.DynamicEdgeRange) : (lensPosition.x - 1f + flare.DynamicEdgeBias + flare.DynamicEdgeRange));
					a2 = a2 * num6 * 0.5f;
				}
				if (!flag6 && flag7)
				{
					b2 = ((!(lensPosition.y > 0.5f)) ? Mathf.Abs(lensPosition.y - flare.DynamicEdgeBias - flare.DynamicEdgeRange) : (lensPosition.y - 1f + flare.DynamicEdgeBias + flare.DynamicEdgeRange));
					b2 = b2 * num6 * 0.5f;
				}
				time = Mathf.Max(a2, b2);
			}
			time = flare.DynamicEdgeCurve.Evaluate(time);
			float num7 = 1f;
			if (flare.UseAngleLimit)
			{
				Vector3 forward = flare.thisTransform.forward;
				Vector3 to = GameCameraTrans.position - flare.thisTransform.position;
				float value = Vector3.Angle(forward, to);
				value = Mathf.Abs(Mathf.Clamp(value, 0f - flare.maxAngle, flare.maxAngle));
				if (value > flare.maxAngle)
				{
					num7 = 0f;
				}
				else
				{
					num7 = 1f - value * (1f / (flare.maxAngle * 0.5f));
					if (flare.UseAngleCurve)
					{
						num7 = flare.AngleCurve.Evaluate(num7);
					}
				}
			}
			float num8 = 1f;
			if (flare.useMaxDistance)
			{
				Vector3 lhs = flare.thisTransform.position - GameCameraTrans.position;
				float num9 = Vector3.Dot(lhs, GameCameraTrans.forward);
				float num10 = 1f - num9 / flare.GlobalMaxDistance;
				num8 = 1f * num10;
				if (num8 < 0.001f)
				{
					flare.isVisible = false;
				}
			}
			if (!dirty && occlusion != null)
			{
				if (occlusion.occluded)
				{
					occlusion.occlusionScale = Mathf.Lerp(occlusion.occlusionScale, 0f, Time.deltaTime * 16f);
				}
				else
				{
					occlusion.occlusionScale = Mathf.Lerp(occlusion.occlusionScale, 1f, Time.deltaTime * 16f);
				}
			}
			if (!flare.isVisible)
			{
				num2 = 0f;
			}
			float num11 = 1f;
			if ((bool)FlareCamera)
			{
				helperTransform.position = FlareCamera.ViewportToWorldPoint(lensPosition);
			}
			lensPosition = helperTransform.localPosition;
			if (!VR_Mode && !SingleCamera_Mode)
			{
				lensPosition.z = 0f;
			}
			for (int j = 0; j < flare.Elements.Count; j++)
			{
				ProFlareElement proFlareElement = flare.Elements[j];
				Color globalTintColor = flare.GlobalTintColor;
				if (flag)
				{
					switch (proFlareElement.type)
					{
					case ProFlareElement.Type.Single:
					{
						proFlareElement.ElementFinalColor.r = proFlareElement.ElementTint.r * globalTintColor.r;
						proFlareElement.ElementFinalColor.g = proFlareElement.ElementTint.g * globalTintColor.g;
						proFlareElement.ElementFinalColor.b = proFlareElement.ElementTint.b * globalTintColor.b;
						float num12 = proFlareElement.ElementTint.a * globalTintColor.a;
						if (flare.useDynamicEdgeBoost)
						{
							num12 = ((!proFlareElement.OverrideDynamicEdgeBrightness) ? (num12 + flare.DynamicEdgeBrightness * time) : (num12 + proFlareElement.DynamicEdgeBrightnessOverride * time));
						}
						if (flare.useDynamicCenterBoost)
						{
							num12 = ((!proFlareElement.OverrideDynamicCenterBrightness) ? (num12 + flare.DynamicCenterBrightness * num4) : (num12 + proFlareElement.DynamicCenterBrightnessOverride * num4));
						}
						if (flare.UseAngleBrightness)
						{
							num12 *= num7;
						}
						if (flare.useDistanceFade)
						{
							num12 *= num8;
						}
						num12 *= occlusion.occlusionScale;
						num12 *= occlusion.cullFader;
						num12 *= num2;
						proFlareElement.ElementFinalColor.a = num12;
						break;
					}
					case ProFlareElement.Type.Multi:
					{
						for (int k = 0; k < proFlareElement.subElements.Count; k++)
						{
							SubElement subElement = proFlareElement.subElements[k];
							subElement.colorFinal.r = subElement.color.r * globalTintColor.r;
							subElement.colorFinal.g = subElement.color.g * globalTintColor.g;
							subElement.colorFinal.b = subElement.color.b * globalTintColor.b;
							float num12 = subElement.color.a * globalTintColor.a;
							if (flare.useDynamicEdgeBoost)
							{
								num12 = ((!proFlareElement.OverrideDynamicEdgeBrightness) ? (num12 + flare.DynamicEdgeBrightness * time) : (num12 + proFlareElement.DynamicEdgeBrightnessOverride * time));
							}
							if (flare.useDynamicCenterBoost)
							{
								num12 = ((!proFlareElement.OverrideDynamicCenterBrightness) ? (num12 + flare.DynamicCenterBrightness * num4) : (num12 + proFlareElement.DynamicCenterBrightnessOverride * num4));
							}
							if (flare.UseAngleBrightness)
							{
								num12 *= num7;
							}
							if (flare.useDistanceFade)
							{
								num12 *= num8;
							}
							num12 *= occlusion.occlusionScale;
							num12 *= occlusion.cullFader;
							num12 *= num2;
							subElement.colorFinal.a = num12;
						}
						break;
					}
					}
				}
				else
				{
					switch (proFlareElement.type)
					{
					case ProFlareElement.Type.Single:
						num11 = 0f;
						break;
					case ProFlareElement.Type.Multi:
						num11 = 0f;
						break;
					}
				}
				float num13 = num11;
				if (flare.useDynamicEdgeBoost)
				{
					num13 = ((!proFlareElement.OverrideDynamicEdgeBoost) ? (num13 + time * flare.DynamicEdgeBoost) : (num13 + time * proFlareElement.DynamicEdgeBoostOverride));
				}
				if (flare.useDynamicCenterBoost)
				{
					num13 = ((!proFlareElement.OverrideDynamicCenterBoost) ? (num13 + flare.DynamicCenterBoost * num4) : (num13 + proFlareElement.DynamicCenterBoostOverride * num4));
				}
				if (num13 < 0f)
				{
					num13 = 0f;
				}
				if (flare.UseAngleScale)
				{
					num13 *= num7;
				}
				if (flare.useDistanceScale)
				{
					num13 *= num8;
				}
				num13 *= occlusion.occlusionScale;
				if (!proFlareElement.Visible)
				{
					num13 = 0f;
				}
				if (!flag)
				{
					num13 = 0f;
				}
				proFlareElement.ScaleFinal = num13;
				if (flag)
				{
					switch (proFlareElement.type)
					{
					case ProFlareElement.Type.Single:
					{
						Vector3 vector2 = lensPosition * (0f - proFlareElement.position);
						float z2 = lensPosition.z;
						if (VR_Mode)
						{
							float num15 = proFlareElement.position * -1f - 1f;
							z2 = lensPosition.z * (num15 * VR_Depth + 1f);
						}
						Vector3 offsetPosition = new Vector3(Mathf.Lerp(vector2.x, lensPosition.x, proFlareElement.Anamorphic.x), Mathf.Lerp(vector2.y, lensPosition.y, proFlareElement.Anamorphic.y), z2);
						offsetPosition += proFlareElement.OffsetPostion;
						proFlareElement.OffsetPosition = offsetPosition;
						break;
					}
					case ProFlareElement.Type.Multi:
					{
						for (int l = 0; l < proFlareElement.subElements.Count; l++)
						{
							SubElement subElement2 = proFlareElement.subElements[l];
							if (proFlareElement.useRangeOffset)
							{
								Vector3 vector = lensPosition * (0f - subElement2.position);
								float z = lensPosition.z;
								if (VR_Mode)
								{
									float num14 = subElement2.position * -1f - 1f;
									z = lensPosition.z * (num14 * VR_Depth + 1f);
								}
								Vector3 offset = new Vector3(Mathf.Lerp(vector.x, lensPosition.x, proFlareElement.Anamorphic.x), Mathf.Lerp(vector.y, lensPosition.y, proFlareElement.Anamorphic.y), z);
								offset += proFlareElement.OffsetPostion;
								subElement2.offset = offset;
							}
							else
							{
								subElement2.offset = lensPosition * (0f - proFlareElement.position);
							}
						}
						break;
					}
					}
				}
				float num16 = 0f;
				if (proFlareElement.rotateToFlare)
				{
					num16 = Div180_PI * Mathf.Atan2(lensPosition.y, lensPosition.x);
				}
				num16 += lensPosition.x * proFlareElement.rotationSpeed;
				num16 += lensPosition.y * proFlareElement.rotationSpeed;
				num16 += Time.time * proFlareElement.rotationOverTime;
				proFlareElement.FinalAngle = proFlareElement.angle + num16;
			}
			if (!flare.neverCull && useCulling)
			{
				FlareOcclusion.CullingState cullingState = occlusion._CullingState;
				if (flare.isVisible)
				{
					visibleFlares++;
					if (occlusion.occluded)
					{
						if (cullingState == FlareOcclusion.CullingState.Visible)
						{
							occlusion.CullTimer = cullFlaresAfterTime;
							cullingState = FlareOcclusion.CullingState.CullCountDown;
						}
					}
					else
					{
						if (cullingState == FlareOcclusion.CullingState.Culled)
						{
							culledFlaresNowVisiable = true;
						}
						cullingState = FlareOcclusion.CullingState.Visible;
					}
				}
				else if (cullingState == FlareOcclusion.CullingState.Visible)
				{
					occlusion.CullTimer = cullFlaresAfterTime;
					cullingState = FlareOcclusion.CullingState.CullCountDown;
				}
				FlareOcclusion.CullingState cullingState2 = cullingState;
				if (cullingState2 != 0 && cullingState2 == FlareOcclusion.CullingState.CullCountDown)
				{
					occlusion.CullTimer -= Time.deltaTime;
					if (occlusion.CullTimer < 0f)
					{
						cullingState = FlareOcclusion.CullingState.CanCull;
					}
				}
				if (cullingState != FlareOcclusion.CullingState.Culled)
				{
					occlusion.cullFader = Mathf.Clamp01(occlusion.cullFader + Time.deltaTime);
				}
				if (cullingState == FlareOcclusion.CullingState.CanCull)
				{
					num++;
				}
				occlusion._CullingState = cullingState;
			}
			reshowCulledFlaresTimer += Time.deltaTime;
			if (reshowCulledFlaresTimer > reshowCulledFlaresAfter)
			{
				reshowCulledFlaresTimer = 0f;
				if (culledFlaresNowVisiable)
				{
					dirty = true;
					culledFlaresNowVisiable = false;
				}
			}
			if (!dirty && num >= cullFlaresAfterCount)
			{
				Debug.Log("Culling Flares");
				dirty = true;
			}
		}
		int num17 = 0;
		if (FlareElementsArray == null)
		{
			return;
		}
		for (int m = 0; m < FlareElementsArray.Length; m++)
		{
			float num18 = 1f;
			ProFlare flare2 = FlareElementsArray[m].flare;
			if (flare2.MultiplyScaleByTransformScale)
			{
				num18 = flare2.thisTransform.localScale.x;
			}
			switch (FlareElementsArray[m].type)
			{
			case ProFlareElement.Type.Single:
			{
				int num22 = num17 * 4;
				if (FlareElementsArray[m].flare.DisabledPlayMode)
				{
					vertices[0 + num22] = Vector3.zero;
					vertices[1 + num22] = Vector3.zero;
					vertices[2 + num22] = Vector3.zero;
					vertices[3 + num22] = Vector3.zero;
				}
				_scale = FlareElementsArray[m].size * FlareElementsArray[m].Scale * 0.01f * flare2.GlobalScale * FlareElementsArray[m].ScaleFinal * num18;
				if (_scale.x < 0f || _scale.y < 0f)
				{
					_scale = Vector3.zero;
				}
				Vector3 offsetPosition2 = FlareElementsArray[m].OffsetPosition;
				float finalAngle2 = FlareElementsArray[m].FinalAngle;
				_color = FlareElementsArray[m].ElementFinalColor;
				if (useBrightnessThreshold)
				{
					if (_color.a < BrightnessThreshold)
					{
						_scale = Vector2.zero;
					}
					else if (_color.r + _color.g + _color.b < BrightnessThreshold)
					{
						_scale = Vector2.zero;
					}
				}
				if (overdrawDebug)
				{
					_color = new Color32(20, 20, 20, 100);
				}
				if (!FlareElementsArray[m].flare.DisabledPlayMode)
				{
					float f2 = finalAngle2 * PI_Div180;
					float num23 = Mathf.Cos(f2);
					float num24 = Mathf.Sin(f2);
					vertices[0 + num22] = new Vector3(num23 * (1f * _scale.x) - num24 * (1f * _scale.y), num24 * (1f * _scale.x) + num23 * (1f * _scale.y), 0f) + offsetPosition2;
					vertices[1 + num22] = new Vector3(num23 * (1f * _scale.x) - num24 * (-1f * _scale.y), num24 * (1f * _scale.x) + num23 * (-1f * _scale.y), 0f) + offsetPosition2;
					vertices[2 + num22] = new Vector3(num23 * (-1f * _scale.x) - num24 * (1f * _scale.y), num24 * (-1f * _scale.x) + num23 * (1f * _scale.y), 0f) + offsetPosition2;
					vertices[3 + num22] = new Vector3(num23 * (-1f * _scale.x) - num24 * (-1f * _scale.y), num24 * (-1f * _scale.x) + num23 * (-1f * _scale.y), 0f) + offsetPosition2;
				}
				Color32 color2 = _color;
				colors[0 + num22] = color2;
				colors[1 + num22] = color2;
				colors[2 + num22] = color2;
				colors[3 + num22] = color2;
				num17++;
				break;
			}
			case ProFlareElement.Type.Multi:
			{
				for (int n = 0; n < FlareElementsArray[m].subElements.Count; n++)
				{
					int num19 = (num17 + n) * 4;
					if (FlareElementsArray[m].flare.DisabledPlayMode)
					{
						vertices[0 + num19] = Vector3.zero;
						vertices[1 + num19] = Vector3.zero;
						vertices[2 + num19] = Vector3.zero;
						vertices[3 + num19] = Vector3.zero;
						continue;
					}
					_scale = FlareElementsArray[m].size * FlareElementsArray[m].Scale * 0.01f * FlareElementsArray[m].flare.GlobalScale * FlareElementsArray[m].subElements[n].scale * FlareElementsArray[m].ScaleFinal;
					_scale *= num18;
					if (_scale.x < 0f || _scale.y < 0f)
					{
						_scale = Vector3.zero;
					}
					Vector3 offset2 = FlareElementsArray[m].subElements[n].offset;
					float finalAngle = FlareElementsArray[m].FinalAngle;
					finalAngle += FlareElementsArray[m].subElements[n].angle;
					_color = FlareElementsArray[m].subElements[n].colorFinal;
					if (useBrightnessThreshold)
					{
						if (_color.a < BrightnessThreshold)
						{
							_scale = Vector2.zero;
						}
						else if (_color.r + _color.g + _color.b < BrightnessThreshold)
						{
							_scale = Vector2.zero;
						}
					}
					if (overdrawDebug)
					{
						_color = new Color32(20, 20, 20, 100);
					}
					if (!FlareElementsArray[m].flare.DisabledPlayMode)
					{
						float f = finalAngle * PI_Div180;
						float num20 = Mathf.Cos(f);
						float num21 = Mathf.Sin(f);
						vertices[0 + num19] = new Vector3(num20 * (1f * _scale.x) - num21 * (1f * _scale.y), num21 * (1f * _scale.x) + num20 * (1f * _scale.y), 0f) + offset2;
						vertices[1 + num19] = new Vector3(num20 * (1f * _scale.x) - num21 * (-1f * _scale.y), num21 * (1f * _scale.x) + num20 * (-1f * _scale.y), 0f) + offset2;
						vertices[2 + num19] = new Vector3(num20 * (-1f * _scale.x) - num21 * (1f * _scale.y), num21 * (-1f * _scale.x) + num20 * (1f * _scale.y), 0f) + offset2;
						vertices[3 + num19] = new Vector3(num20 * (-1f * _scale.x) - num21 * (-1f * _scale.y), num21 * (-1f * _scale.x) + num20 * (-1f * _scale.y), 0f) + offset2;
					}
					Color32 color = _color;
					colors[0 + num19] = color;
					colors[1 + num19] = color;
					colors[2 + num19] = color;
					colors[3 + num19] = color;
				}
				num17 += FlareElementsArray[m].subElements.Count;
				break;
			}
			}
		}
	}

	public void Reset()
	{
		if (helperTransform == null)
		{
			CreateHelperTransform();
		}
		mat = new Material(Shader.Find("ProFlares/Textured Flare Shader"));
		if (meshFilter == null)
		{
			meshFilter = GetComponent<MeshFilter>();
		}
		if (meshFilter == null)
		{
			meshFilter = base.gameObject.AddComponent<MeshFilter>();
		}
		meshRender = base.gameObject.GetComponent<MeshRenderer>();
		if (meshRender == null)
		{
			meshRender = base.gameObject.AddComponent<MeshRenderer>();
		}
		if (FlareCamera == null)
		{
			FlareCamera = base.transform.root.GetComponentInChildren<Camera>();
		}
		meshRender.material = mat;
		SetupMeshes();
		dirty = true;
	}

	public void SwitchCamera(Camera newCamera)
	{
		GameCamera = newCamera;
		GameCameraTrans = newCamera.transform;
		FixedUpdate();
		for (int i = 0; i < FlaresList.Count; i++)
		{
			if (FlaresList[i].occlusion != null && FlaresList[i].occlusion.occluded)
			{
				FlaresList[i].occlusion.occlusionScale = 0f;
			}
		}
	}

	public void RemoveFlare(ProFlare _flare)
	{
		bool flag = false;
		FlareData item = null;
		for (int i = 0; i < FlaresList.Count; i++)
		{
			if (_flare == FlaresList[i].flare)
			{
				item = FlaresList[i];
				flag = true;
				break;
			}
		}
		if (flag)
		{
			FlaresList.Remove(item);
		}
	}

	public void AddFlare(ProFlare _flare)
	{
		bool flag = false;
		for (int i = 0; i < FlaresList.Count; i++)
		{
			if (_flare == FlaresList[i].flare)
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			FlareData flareData = new FlareData();
			flareData.flare = _flare;
			FlareOcclusion flareOcclusion = new FlareOcclusion();
			if (_flare.neverCull)
			{
				flareOcclusion._CullingState = FlareOcclusion.CullingState.NeverCull;
			}
			flareData.occlusion = flareOcclusion;
			FlaresList.Add(flareData);
			dirty = true;
		}
	}

	public void UpdateVisibility(bool status)
	{
		for (int i = 0; i < FlaresList.Count; i++)
		{
			if (!(FlaresList[i].flare == null))
			{
				ProFlare flare = FlaresList[i].flare;
				FlareOcclusion occlusion = FlaresList[i].occlusion;
				occlusion.occluded = true;
				if (flare.isVisible)
				{
					occlusion.occluded = status;
				}
			}
		}
	}

	public void UpdateFlares()
	{
		bufferMesh = ((!PingPong) ? meshB : meshA);
		PingPong = !PingPong;
		UpdateGeometry();
		if (bufferMesh != null)
		{
			bufferMesh.vertices = vertices;
			bufferMesh.colors32 = colors;
			meshFilter.sharedMesh = bufferMesh;
		}
	}

	public void ForceRefresh()
	{
		FlaresList.Clear();
		ProFlare[] array = UnityEngine.Object.FindObjectsOfType(typeof(ProFlare)) as ProFlare[];
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i]._Atlas == _atlas)
			{
				AddFlare(array[i]);
			}
		}
		dirty = true;
	}

	private void Awake()
	{
		PI_Div180 = (float)Math.PI / 180f;
		Div180_PI = 180f / (float)Math.PI;
		ProFlare[] array = UnityEngine.Object.FindObjectsOfType(typeof(ProFlare)) as ProFlare[];
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i]._Atlas == _atlas)
			{
				AddFlare(array[i]);
			}
		}
	}

	private void Start()
	{
		if (Application.isPlaying)
		{
			overdrawDebug = false;
		}
		if (GameCamera == null)
		{
			GameObject gameObject = GameObject.FindWithTag("MainCamera");
			if ((bool)gameObject && (bool)gameObject.GetComponent<Camera>())
			{
				GameCamera = gameObject.GetComponent<Camera>();
			}
		}
		if ((bool)GameCamera)
		{
			GameCameraTrans = GameCamera.transform;
		}
		thisTransform = base.transform;
		SetupMeshes();
	}

	private void Update()
	{
		if ((bool)thisTransform)
		{
			thisTransform.localPosition = Vector3.forward * zPos;
		}
		if (helperTransform == null)
		{
			CreateHelperTransform();
		}
		if ((bool)meshRender)
		{
			if (meshRender.sharedMaterial == null)
			{
				CreateMat();
			}
		}
		else
		{
			meshRender = base.gameObject.GetComponent<MeshRenderer>();
		}
		bool flag = false;
		if (meshA == null)
		{
			flag = true;
		}
		if (meshB == null)
		{
			flag = true;
		}
		if (flag && _atlas != null)
		{
			SetupMeshes();
		}
		if (dirty)
		{
			ReBuildGeometry();
		}
	}

	private void FixedUpdate()
	{
	}

	private void LateUpdate()
	{
		if (!(_atlas == null))
		{
			UpdateFlares();
		}
	}

	private void OnDestroy()
	{
		if (Application.isPlaying)
		{
			UnityEngine.Object.Destroy(helperTransform.gameObject);
			UnityEngine.Object.Destroy(mat);
		}
		else
		{
			UnityEngine.Object.DestroyImmediate(helperTransform.gameObject);
			UnityEngine.Object.DestroyImmediate(mat);
		}
	}
}
