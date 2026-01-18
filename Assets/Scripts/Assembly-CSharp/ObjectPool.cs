using System;
using System.Collections;
using System.Collections.Generic;

public abstract class ObjectPool : IDisposable
{
	public ICollection collection;

	public override string ToString()
	{
		return string.Format("ObjectPool {0}: {1}", collection.GetType(), collection.Count);
	}

	public abstract void Dispose();
}
public class ObjectPool<T> : ObjectPool where T : new()
{
	public Queue<T> queue;

	private List<T> free_;

	private int freeCount_;

	private int maxAmount_;

	public ObjectPool()
	{
		maxAmount_ = int.MaxValue;
		queue = new Queue<T>();
		collection = queue;
	}

	public void SetMaxAmount(int maxAmount)
	{
		if (maxAmount_ != maxAmount)
		{
			maxAmount_ = maxAmount;
			if (free_ == null)
			{
				free_ = new List<T>();
			}
			else
			{
				free_.Clear();
			}
		}
	}

	public void MarkFree(T obj)
	{
		if (!free_.Contains(obj))
		{
			free_.Insert(0, obj);
			freeCount_ = free_.Count;
		}
	}

	public void MarkUsed(T obj)
	{
		if (free_.Contains(obj))
		{
			free_.Remove(obj);
			freeCount_ = free_.Count;
		}
	}

	public T Get()
	{
		T val;
		if (queue.Count > 0)
		{
			val = queue.Dequeue();
		}
		else if (freeCount_ >= maxAmount_)
		{
			val = free_[freeCount_ - 1];
			free_.RemoveAt(freeCount_ - 1);
			free_.Insert(0, val);
			freeCount_ = free_.Count;
		}
		else
		{
			val = new T();
		}
		return val;
	}

	public void Release(T obj)
	{
		if (obj != null)
		{
			queue.Enqueue(obj);
			if (free_ != null && free_.Contains(obj))
			{
				free_.Remove(obj);
				freeCount_ = free_.Count;
			}
		}
	}

	public override void Dispose()
	{
		while (queue.Count > 0)
		{
			T val = queue.Dequeue();
			IDisposable disposable = val as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
		queue.Clear();
		if (free_ != null)
		{
			for (int i = 0; i < free_.Count; i++)
			{
				T val2 = free_[i];
				IDisposable disposable2 = val2 as IDisposable;
				if (disposable2 != null)
				{
					disposable2.Dispose();
				}
			}
			free_.Clear();
		}
		freeCount_ = 0;
	}
}
