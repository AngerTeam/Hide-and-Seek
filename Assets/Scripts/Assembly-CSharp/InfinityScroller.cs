using System;
using DG.Tweening;
using Extensions;
using UnityEngine;

public class InfinityScroller : MonoBehaviour
{
	[Header("UIElements")]
	public GameObject Container;

	public UIScrollView ScrollView;

	[Header("Attributes")]
	public float SpinTime;

	public float cellWidth;

	public float cellHeight;

	public int MinElementsCount;

	public int OriginalElementsCount;

	public int VisualElementsCount;

	private ScrollerElement[] elements_;

	private ScrollerElement firstElement;

	private ScrollerElement centerElement;

	private ScrollerElement lastElement;

	private Sequence sequence_;

	private Vector2 spin_;

	private int сircleCount_;

	private int currentIndex_;

	public event Action OnScrollingFinish;

	public event Action OnScrollingStart;

	public event Action OnChangeElement;

	public ScrollerElement GetSelectedElement()
	{
		if (centerElement == null)
		{
			throw new Exception("ERROR: Center element not set.");
		}
		return centerElement;
	}

	public void Dispose()
	{
		for (int i = 0; i < elements_.Length; i++)
		{
			elements_[i].Dispose();
		}
		elements_ = null;
		firstElement = null;
		centerElement = null;
		lastElement = null;
		sequence_ = null;
		spin_ = Vector2.zero;
		сircleCount_ = -1;
		currentIndex_ = -1;
	}

	public void Init<T>(T[] array, bool random = false) where T : MonoBehaviour
	{
		if (array != null && array.Length != 0)
		{
			сircleCount_ = Mathf.CeilToInt((float)MinElementsCount / (float)array.Length);
			OriginalElementsCount = array.Length;
			VisualElementsCount = сircleCount_ * array.Length;
			Generate(array, random);
			Reset();
		}
	}

	public void Spin(int spinCount, int targetIndex)
	{
		if (targetIndex < 0 || targetIndex >= OriginalElementsCount)
		{
			throw new Exception(string.Format("ERROR: Wrong spin index: {0} / {1}", targetIndex, OriginalElementsCount));
		}
		ScrollerElement elementByRealIndex = GetElementByRealIndex(targetIndex);
		if (elementByRealIndex != null)
		{
			Vector3[] worldCorners = ScrollView.panel.worldCorners;
			Vector3 position = (worldCorners[2] + worldCorners[0]) * 0.5f;
			Transform cachedTransform = ScrollView.panel.cachedTransform;
			Vector3 vector = cachedTransform.InverseTransformPoint(elementByRealIndex.element.transform.position);
			Vector3 vector2 = cachedTransform.InverseTransformPoint(position);
			Vector3 vector3 = vector - vector2;
			Vector3 vector4 = new Vector3((float)(spinCount * elements_.Length) * cellWidth, 0f, 0f);
			Tween(cachedTransform.localPosition - vector4 - vector3, -1f);
		}
		else
		{
			Debug.LogErrorFormat("ERROR: Element with index {0} not found", targetIndex);
		}
	}

	public void ShiftScrollElementsByElements(int elements)
	{
		ShiftScrollElementsToIndex(currentIndex_ + elements);
	}

	public void ShiftScrollElementsToIndex(int index)
	{
		float num = 0f;
		if (elements_.Length % 2 == 0)
		{
			num = cellWidth / 2f;
		}
		Vector2 newPosition = ScrollView.transform.localPosition;
		newPosition.x = -1f * (cellWidth * (float)index);
		newPosition.x += num;
		Tween(newPosition, 2.5f);
	}

	private ScrollerElement GetElementByRealIndex(int index)
	{
		for (int i = 0; i < elements_.Length; i++)
		{
			if (elements_[i].index == index)
			{
				return elements_[i];
			}
		}
		return null;
	}

	private void Generate<T>(T[] array, bool random = false) where T : MonoBehaviour
	{
		elements_ = new ScrollerElement[сircleCount_ * array.Length];
		int i = 0;
		int num = 0;
		for (; i < сircleCount_; i++)
		{
			if (random)
			{
				int[] array2 = new int[array.Length];
				for (int j = 0; j < array.Length; j++)
				{
					array2[j] = j;
				}
				array2 = Shuffle(array2);
				int num2 = 0;
				while (num2 < array.Length)
				{
					GameObject gameObject = Container.gameObject.AddChild(array[array2[num2]].gameObject);
					elements_[num] = new ScrollerElement(gameObject.transform, array2[num2]);
					num2++;
					num++;
				}
			}
			else
			{
				int num3 = 0;
				while (num3 < array.Length)
				{
					GameObject gameObject2 = Container.gameObject.AddChild(array[num3].gameObject);
					elements_[num] = new ScrollerElement(gameObject2.transform, num3);
					num3++;
					num++;
				}
			}
		}
		for (int k = 0; k < array.Length; k++)
		{
			UnityEngine.Object.Destroy(array[k].gameObject);
		}
	}

	private T[] Shuffle<T>(T[] list)
	{
		int num = list.Length;
		while (num > 1)
		{
			num--;
			int num2 = UnityEngine.Random.Range(0, num + 1);
			T val = list[num2];
			list[num2] = list[num];
			list[num] = val;
		}
		return list;
	}

	private void Tween(Vector2 newPosition, float time = -1f)
	{
		if (time < 0f)
		{
			time = SpinTime;
		}
		if (sequence_ != null)
		{
			sequence_.Kill();
		}
		sequence_ = DOTween.Sequence();
		sequence_.Insert(0f, DOTween.To(() => spin_, delegate(Vector2 x)
		{
			spin_ = x;
			UpdateScrollView(spin_);
		}, newPosition, time).SetOptions(AxisConstraint.X));
		sequence_.OnStart(OnScrollingStarted);
		sequence_.OnComplete(OnScrollingFinished);
	}

	private void OnScrollingStarted()
	{
		this.OnScrollingStart.SafeInvoke();
	}

	private void OnScrollingFinished()
	{
		this.OnScrollingFinish.SafeInvoke();
	}

	private void UpdateScrollView(Vector2 position)
	{
		ScrollView.transform.localPosition = new Vector2(position.x, ScrollView.transform.localPosition.y);
		ScrollView.panel.clipOffset = -1f * new Vector2(position.x, 0f);
	}

	private void UpdateElements(int elements)
	{
		if (elements_ == null || elements_.Length == 0)
		{
			return;
		}
		for (int i = 0; i < Mathf.Abs(elements); i++)
		{
			Vector2 zero = Vector2.zero;
			if (elements > 0)
			{
				zero.x = lastElement.element.localPosition.x + cellWidth;
				firstElement.element.localPosition = zero;
				firstElement = firstElement.nextElement;
				centerElement = centerElement.nextElement;
				lastElement = lastElement.nextElement;
				currentIndex_++;
			}
			else
			{
				zero.x = firstElement.element.localPosition.x - cellWidth;
				lastElement.element.localPosition = zero;
				firstElement = firstElement.prevElement;
				centerElement = centerElement.prevElement;
				lastElement = lastElement.prevElement;
				currentIndex_--;
			}
		}
		this.OnChangeElement.SafeInvoke();
	}

	private void Reposition()
	{
		ScrollView.transform.localPosition = new Vector2(0f, ScrollView.transform.localPosition.y);
		ScrollView.panel.clipOffset = Vector2.zero;
		if (elements_ != null && elements_.Length > 0)
		{
			float num = cellWidth * (float)elements_.Length;
			float num2 = (0f - num) / 2f;
			for (int i = 0; i < elements_.Length; i++)
			{
				elements_[i].element.localPosition = new Vector3(num2, 0f, 0f);
				num2 += cellWidth;
			}
		}
	}

	private void Reset()
	{
		currentIndex_ = 0;
		for (int i = 0; i < elements_.Length; i++)
		{
			if (i > 0)
			{
				elements_[i].prevElement = elements_[i - 1];
				elements_[i - 1].nextElement = elements_[i];
			}
			if (i == elements_.Length - 1)
			{
				elements_[elements_.Length - 1].nextElement = elements_[0];
				elements_[0].prevElement = elements_[elements_.Length - 1];
			}
		}
		firstElement = elements_[0];
		centerElement = elements_[Mathf.FloorToInt(elements_.Length / 2)];
		lastElement = elements_[elements_.Length - 1];
		Reposition();
	}

	private void Update()
	{
		int num = -1 * Mathf.FloorToInt(ScrollView.transform.localPosition.x / cellWidth);
		if (currentIndex_ != num)
		{
			UpdateElements(num - currentIndex_);
		}
		currentIndex_ = num;
	}
}
