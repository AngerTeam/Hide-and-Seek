using System;
using System.Text;
using System.Threading;
using CraftyEngine.Utils;
using UnityEngine;

public class ThreadManager : Singleton
{
	public static bool profilerMode;

	public VoteCounter inProgressBy;

	public ThreadHolder[] threadHolders;

	private bool disposed_;

	public int FreeSafeCount { get; private set; }

	public bool InProgress
	{
		get
		{
			for (int i = 0; i < TotalCount; i++)
			{
				ThreadHolder threadHolder = threadHolders[i];
				if (threadHolder.reserved)
				{
					return true;
				}
			}
			if (inProgressBy.actualValue)
			{
				return true;
			}
			return false;
		}
	}

	public int SafeCount { get; private set; }

	public int TotalCount { get; private set; }

	public ThreadManager()
	{
		inProgressBy = new VoteCounter();
		inProgressBy.mainAnchor = true;
		int val = System.Math.Max(Environment.ProcessorCount, SystemInfo.processorCount);
		TotalCount = System.Math.Max(2, val);
		SafeCount = TotalCount - 1;
		FreeSafeCount = SafeCount;
		threadHolders = new ThreadHolder[TotalCount];
		for (int i = 0; i < TotalCount; i++)
		{
			threadHolders[i] = new ThreadHolder();
		}
	}

	public override void Dispose()
	{
		disposed_ = true;
		ReleaseAll();
		try
		{
			Monitor.Enter(this);
			threadHolders = null;
		}
		finally
		{
			Monitor.Exit(this);
		}
	}

	public ThreadHolder GetExtraThread()
	{
		if (disposed_)
		{
			return null;
		}
		ThreadHolder threadHolder = new ThreadHolder();
		if (profilerMode)
		{
			threadHolder.AddProfiler();
		}
		return threadHolder;
	}

	public override void Init()
	{
		if (profilerMode)
		{
			for (int i = 0; i < TotalCount; i++)
			{
				threadHolders[i].AddProfiler();
			}
		}
	}

	public void Release(ThreadHolder holder)
	{
		holder.reserved = false;
		FreeSafeCount++;
		holder.debugName = "idle";
		holder.started = DateTime.Now.Ticks;
	}

	public void Start(ThreadHolder holder, Action action, bool background, string debugName)
	{
		if (disposed_)
		{
			return;
		}
		holder.started = DateTime.Now.Ticks;
		holder.debugName = debugName;
		if (profilerMode)
		{
			holder.profiler.action = action;
			holder.profiler.debugName = debugName;
			return;
		}
		if (CompileConstants.MOBILE)
		{
			ThreadPool.QueueUserWorkItem(delegate
			{
				Execute(holder, action);
			});
			return;
		}
		Thread thread = new Thread((ThreadStart)delegate
		{
			Execute(holder, action);
		});
		thread.Start();
	}

	private void Execute(ThreadHolder holder, Action action)
	{
		try
		{
			action();
		}
		catch (Exception ex)
		{
			if (!(ex is ThreadAbortException))
			{
				Log.Exception(ex);
			}
		}
		Release(holder);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("ThreadManager: ");
		for (int i = 0; i < TotalCount; i++)
		{
			ThreadHolder threadHolder = threadHolders[i];
			stringBuilder.AppendLine(threadHolder.ToString());
		}
		return stringBuilder.ToString();
	}

	public bool TryReserve(out ThreadHolder holder, bool safe = true)
	{
		if (disposed_)
		{
			holder = null;
			return false;
		}
		try
		{
			Monitor.Enter(this);
			if (threadHolders != null)
			{
				int num = ((!safe) ? TotalCount : SafeCount);
				for (int i = 0; i < num; i++)
				{
					holder = threadHolders[i];
					if (!holder.reserved)
					{
						holder.reserved = true;
						FreeSafeCount--;
						return true;
					}
				}
			}
			holder = null;
			return false;
		}
		finally
		{
			Monitor.Exit(this);
		}
	}

	internal void Abort(ThreadHolder holder, int id)
	{
	}

	internal void Lock(object obj)
	{
		Monitor.Enter(obj);
	}

	internal void Unlock(object obj)
	{
		Monitor.Exit(obj);
	}

	internal void ReleaseAll()
	{
		try
		{
			Monitor.Enter(this);
			for (int i = 0; i < TotalCount; i++)
			{
				ThreadHolder holder = threadHolders[i];
				Abort(holder, i);
				Release(holder);
			}
		}
		finally
		{
			Monitor.Exit(this);
		}
	}
}
