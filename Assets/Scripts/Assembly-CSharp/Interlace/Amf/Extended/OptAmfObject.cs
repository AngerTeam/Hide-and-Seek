using System;
using System.Collections.Generic;

namespace Interlace.Amf.Extended
{
	public class OptAmfObject : AmfObject, IDisposable
	{
		private bool disposed_;

		public OptAmfObject()
			: base(false)
		{
			_properties = AmfOptimizationPools.ObjectDictionary.Get();
		}

		public void Dispose()
		{
			if (!disposed_)
			{
				disposed_ = true;
				Dictionary<string, object>.Enumerator enumerator = _properties.GetEnumerator();
				while (enumerator.MoveNext())
				{
					AmfDisposer.Dispose(enumerator.Current.Value);
				}
				enumerator.Dispose();
				_properties.Clear();
				AmfOptimizationPools.ObjectDictionary.Release(_properties);
			}
		}
	}
}
