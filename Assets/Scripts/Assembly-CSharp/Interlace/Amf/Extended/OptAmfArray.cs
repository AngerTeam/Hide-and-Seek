using System;
using System.Collections.Generic;

namespace Interlace.Amf.Extended
{
	public class OptAmfArray : AmfArray, IDisposable
	{
		private bool disposed_;

		public OptAmfArray()
			: base(false)
		{
			_denseElements = AmfOptimizationPools.ObjectList.Get();
			_associativeElements = AmfOptimizationPools.ObjectDictionary.Get();
		}

		public void Dispose()
		{
			if (!disposed_)
			{
				disposed_ = true;
				for (int i = 0; i < _denseElements.Count; i++)
				{
					AmfDisposer.Dispose(_denseElements[i]);
				}
				Dictionary<string, object>.Enumerator enumerator = _associativeElements.GetEnumerator();
				while (enumerator.MoveNext())
				{
					AmfDisposer.Dispose(enumerator.Current.Value);
				}
				enumerator.Dispose();
				_denseElements.Clear();
				_associativeElements.Clear();
				AmfOptimizationPools.ObjectList.Release(_denseElements);
				AmfOptimizationPools.ObjectDictionary.Release(_associativeElements);
			}
		}
	}
}
