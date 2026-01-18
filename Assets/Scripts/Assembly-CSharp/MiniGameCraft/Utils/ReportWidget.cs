using UnityEngine;
using WindowsModule;

namespace MiniGameCraft.Utils
{
	public class ReportWidget : MonoBehaviour
	{
		private float sendTime_;

		public float deltaTime = 5f;

		public float xPart = 0.1f;

		public float yPart = 0.1f;

		private int xGap = 15;

		private int yGap = 15;

		[Space(10f)]
		public bool TopLeft = true;

		public bool TopRight;

		public bool BottomLeft;

		public bool BottomRight;

		[Space(10f)]
		public string MessageText = "Sending logs to server!";

		private bool tracking_;

		public void Start()
		{
			Object.DontDestroyOnLoad(base.gameObject);
			xGap = (int)((float)Screen.width * xPart);
			yGap = (int)((float)Screen.height * yPart);
		}

		public void Update()
		{
			if (Input.touchCount <= 0)
			{
				return;
			}
			Touch touch = Input.GetTouch(0);
			if (touch.phase == TouchPhase.Began && TestPoint(touch.position))
			{
				tracking_ = true;
				sendTime_ = Time.unscaledTime + deltaTime;
			}
			if (touch.phase != TouchPhase.Stationary || !tracking_)
			{
				return;
			}
			if (TestPoint(touch.position))
			{
				if (Time.unscaledTime > sendTime_)
				{
					tracking_ = false;
					ShowSendMessage();
				}
			}
			else
			{
				tracking_ = false;
			}
		}

		private void ShowSendMessage()
		{
			DialogWindowManager singlton;
			SingletonManager.Get<DialogWindowManager>(out singlton);
			singlton.ShowMessage(MessageText);
			SendLogs();
		}

		private bool TestPoint(Vector2 point)
		{
			bool flag = point.y > (float)(Screen.height - yGap);
			bool flag2 = point.y < (float)yGap;
			bool flag3 = point.x < (float)xGap;
			bool flag4 = point.x > (float)(Screen.width - xGap);
			return (flag && flag3 && TopLeft) || (flag && flag4 && TopRight) || (flag2 && flag3 && BottomLeft) || (flag2 && flag4 && BottomRight);
		}

		private void SendLogs()
		{
			LogReporter.Report();
		}
	}
}
