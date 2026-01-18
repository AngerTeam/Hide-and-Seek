using System;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

namespace CraftyEngine
{
	public class ThreadDataTransfer<T> : IDisposable
	{
		public bool holdProcess;

		private bool abort_;

		private Queue<T> accumulator_;

		private Queue<T> dispatcher_;

		private bool dispatching_;

		private Thread thread_;

		private bool transfering_;

		private bool disposed_;

		public event Action<T> Process;

		public ThreadDataTransfer(bool processInUnity)
		{
			accumulator_ = new Queue<T>();
			dispatcher_ = new Queue<T>();
			if (!processInUnity)
			{
				abort_ = false;
				thread_ = new Thread(Loop);
				thread_.Start();
			}
		}

		public override string ToString()
		{
			return string.Format("ThreadDataTransfer of {0}: {1} dispatching, {2} accumulated", typeof(T).Name, dispatcher_.Count, accumulator_.Count);
		}

		public virtual void Dispose()
		{
			disposed_ = true;
			if (thread_ == null)
			{
				Abort();
			}
			else
			{
				abort_ = true;
			}
		}

		public void Enqueue(T value)
		{
			try
			{
				Monitor.Enter(accumulator_);
				accumulator_.Enqueue(value);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
			finally
			{
				Monitor.Exit(accumulator_);
			}
		}

		private void Abort()
		{
			dispatcher_.Clear();
			dispatcher_ = null;
			accumulator_.Clear();
			accumulator_ = null;
		}

		private void Dispatch()
		{
			dispatching_ = true;
			if (disposed_)
			{
				return;
			}
			while (dispatcher_.Count > 0 && !holdProcess)
			{
				if (this.Process != null)
				{
					this.Process(dispatcher_.Dequeue());
				}
				if (disposed_)
				{
					return;
				}
			}
			dispatching_ = false;
		}

		private void Loop()
		{
			while (true)
			{
				if (abort_)
				{
					Abort();
					return;
				}
				if (!TryTransfer())
				{
					Abort();
					return;
				}
				if (abort_)
				{
					break;
				}
				if (dispatcher_.Count == 0)
				{
					Thread.Sleep(16);
				}
				else
				{
					Dispatch();
				}
			}
			Abort();
		}

		private bool TryTransfer()
		{
			if (dispatching_ || transfering_ || disposed_)
			{
				return true;
			}
			try
			{
				transfering_ = true;
				Monitor.Enter(accumulator_);
				while (accumulator_.Count > 0)
				{
					T item = accumulator_.Dequeue();
					dispatcher_.Enqueue(item);
				}
				return true;
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				return false;
			}
			finally
			{
				Monitor.Exit(accumulator_);
				transfering_ = false;
			}
		}

		public void Update()
		{
			if (!disposed_)
			{
				if (!TryTransfer())
				{
					Dispose();
				}
				else
				{
					Dispatch();
				}
			}
		}

		public void Clear()
		{
			try
			{
				Monitor.Enter(accumulator_);
				accumulator_.Clear();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
			finally
			{
				Monitor.Exit(accumulator_);
			}
			try
			{
				Monitor.Enter(dispatcher_);
				dispatcher_.Clear();
			}
			catch (Exception exception2)
			{
				Debug.LogException(exception2);
			}
			finally
			{
				Monitor.Exit(dispatcher_);
			}
		}
	}
}
