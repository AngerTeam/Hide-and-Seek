namespace System.Collections.Generic
{
	public class TraceList<T> : IEnumerable, ICollection<T>, IEnumerable<T>, IList<T>
	{
		private List<T> items_ = new List<T>();

		public int Count
		{
			get
			{
				return items_.Count;
			}
		}

		public bool IsReadOnly
		{
			get
			{
				return false;
			}
		}

		public uint MaxSize { get; private set; }

		public T this[int index]
		{
			get
			{
				return items_[index];
			}
			set
			{
				items_[index] = value;
			}
		}

		public TraceList(uint maxSize)
		{
			if (maxSize == 0)
			{
				throw new ArgumentException();
			}
			MaxSize = maxSize;
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return items_.GetEnumerator();
		}

		public void Add(T item)
		{
			if (items_.Count >= MaxSize)
			{
				items_.RemoveAt(0);
			}
			items_.Add(item);
		}

		public void Clear()
		{
			items_.Clear();
		}

		public bool Contains(T item)
		{
			return items_.Contains(item);
		}

		public void CopyTo(T[] array, int arrayIndex)
		{
			items_.CopyTo(array, arrayIndex);
		}

		public IEnumerator<T> GetEnumerator()
		{
			return items_.GetEnumerator();
		}

		public int IndexOf(T item)
		{
			return items_.IndexOf(item);
		}

		public void Insert(int index, T item)
		{
			items_.Insert(index, item);
		}

		public bool Remove(T item)
		{
			return items_.Remove(item);
		}

		public void RemoveAt(int index)
		{
			items_.RemoveAt(index);
		}
	}
}
