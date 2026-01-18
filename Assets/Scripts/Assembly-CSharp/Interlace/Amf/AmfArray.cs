using System.Collections.Generic;

namespace Interlace.Amf
{
	public class AmfArray
	{
		protected List<object> _denseElements;

		protected Dictionary<string, object> _associativeElements;

		public object this[string indexString]
		{
			get
			{
				int result;
				if (int.TryParse(indexString, out result) && 0 <= result && result < _denseElements.Count)
				{
					return _denseElements[result];
				}
				return _associativeElements[indexString];
			}
			set
			{
				int result;
				if (int.TryParse(indexString, out result) && 0 <= result && result < _denseElements.Count)
				{
					_denseElements[result] = value;
				}
				_associativeElements[indexString] = value;
			}
		}

		public object this[int index]
		{
			get
			{
				if (0 <= index && index < _denseElements.Count)
				{
					return _denseElements[index];
				}
				return _associativeElements[index.ToString()];
			}
			set
			{
				if (0 <= index && index < _denseElements.Count)
				{
					_denseElements[index] = value;
				}
				else if (index == _denseElements.Count)
				{
					_denseElements.Add(value);
				}
				else
				{
					_associativeElements[index.ToString()] = value;
				}
			}
		}

		public IList<object> DenseElements
		{
			get
			{
				return _denseElements;
			}
		}

		public IDictionary<string, object> AssociativeElements
		{
			get
			{
				return _associativeElements;
			}
		}

		public bool IsEmpty
		{
			get
			{
				return _associativeElements.Count == 0 && _denseElements.Count == 0;
			}
		}

		public AmfArray()
		{
			_denseElements = new List<object>();
			_associativeElements = new Dictionary<string, object>();
		}

		public AmfArray(bool init)
		{
			if (init)
			{
				_denseElements = new List<object>();
				_associativeElements = new Dictionary<string, object>();
			}
		}

		public AmfArray(IEnumerable<object> denseElements, IDictionary<string, object> associativeElements)
		{
			_denseElements = new List<object>(denseElements);
			_associativeElements = new Dictionary<string, object>(associativeElements);
		}

		public AmfArray(IEnumerable<object> denseElements)
		{
			_denseElements = new List<object>(denseElements);
			_associativeElements = new Dictionary<string, object>();
		}

		public static AmfArray Dense(params object[] elements)
		{
			return new AmfArray(elements);
		}
	}
}
