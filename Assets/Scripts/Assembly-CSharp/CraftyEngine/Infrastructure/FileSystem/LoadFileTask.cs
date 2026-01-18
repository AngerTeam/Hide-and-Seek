using System.Text;

namespace CraftyEngine.Infrastructure.FileSystem
{
	public abstract class LoadFileTask : AsynchronousTask
	{
		public bool silent;

		public int layer;

		public string originalUrl;

		private UnityEvent unityEvent_;

		public LoadState State { get; protected set; }

		public string Address { get; protected set; }

		public string ErrorMessage { get; protected set; }

		public FileHolder File { get; protected set; }

		protected LoadFileTask(int layer)
		{
			silent = false;
			State = LoadState.Idle;
			this.layer = layer;
		}

		internal void SetAddress(string fileUrl)
		{
			Address = fileUrl;
		}

		protected void Unsubscribe()
		{
			if (unityEvent_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
				unityEvent_ = null;
			}
			State = LoadState.Stopped;
		}

		public override void Start()
		{
		}

		public virtual void ReSubscribe()
		{
			Unsubscribe();
			SubscribeToUnityUpdate();
		}

		public void SubscribeToUnityUpdate()
		{
			unityEvent_ = SingletonManager.Get<UnityEvent>(layer);
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			State = LoadState.Loading;
		}

		public abstract void UnityUpdate();

		protected virtual void Init()
		{
			File.fileGetter = this;
		}

		public static void ReadVersion(byte[] bytes, string url)
		{
			if (url.EndsWith(".unity3d"))
			{
				string @string = Encoding.UTF8.GetString(bytes, 18, 6);
				if (!@string.Contains("5.4.5f"))
				{
					Log.Warning("Obsolete bundle {1} {0}", url, @string);
				}
			}
		}

		public virtual void Unload()
		{
			State = LoadState.Unloaded;
		}
	}
}
