using System;
using CraftyEngine;
using CraftyEngine.Infrastructure;
using Extensions;
using Interlace.Amf;
using Interlace.Amf.Extended;

namespace TcpIpNetworkModule
{
	public class TcpIpNetworkWithAmf : TcpIpNetwork
	{
		private ThreadDataTransfer<byte[]> readerTransfer_;

		private ThreadDataTransfer<AmfObject> reportTransfer_;

		private bool disposed_;

		private bool opt_;

		public event Action<AmfObject> AmfMessageRecieved;

		public TcpIpNetworkWithAmf(IUpdate updater, string id, bool experementalOptimisation)
			: base(updater, false, id)
		{
			opt_ = experementalOptimisation;
			updater.Updated += Updater_Updated;
			readerTransfer_ = new ThreadDataTransfer<byte[]>(false);
			readerTransfer_.Process += Read;
			reportTransfer_ = new ThreadDataTransfer<AmfObject>(true);
			reportTransfer_.Process += Report;
			MessageRecieved += OnMessageRecieved;
			base.Connecting += Clear;
		}

		private void Clear()
		{
			if (opt_)
			{
				OptAmfReader.Clear();
			}
			readerTransfer_.Clear();
			reportTransfer_.Clear();
		}

		public override void Dispose()
		{
			if (!disposed_)
			{
				disposed_ = true;
				base.Dispose();
				readerTransfer_.Dispose();
				reportTransfer_.Dispose();
			}
		}

		private void Updater_Updated()
		{
			reportTransfer_.Update();
		}

		private void Report(AmfObject amf)
		{
			this.AmfMessageRecieved.SafeInvoke(amf);
		}

		private void Read(byte[] obj)
		{
			try
			{
				AmfObject value = ((!opt_) ? AmfHelper.ReadObject(obj) : AmfHelper.ReadObjectOpt(obj));
				reportTransfer_.Enqueue(value);
			}
			catch (Exception data)
			{
				Exc.Report(3102, this, data);
				Clear();
			}
		}

		private void OnMessageRecieved(byte[] bytes)
		{
			readerTransfer_.Enqueue(bytes);
		}
	}
}
