using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using DG.Tweening;
using UnityEngine;

namespace PopUpModule
{
	public class PopUpManager : Singleton
	{
		private const int DEFAULT_FONT_SIZE = 60;

		public static readonly Color normalMessageColor = Color.white;

		public static readonly Color warningMessageColor = new Color(1f, 0.4f, 0.1f);

		private UnityEvent unityEvent_;

		private PrefabsManager prefabsManager_;

		private PopUpHierarchy hierarchy_;

		private bool needToUpdate;

		private Queue<Message> messages;

		public int mesagesLimit = 5;

		public float step = 80f;

		public float messageFadeTime = 0.5f;

		public float messageLifeTime = 3f;

		public float startHeight = -80f;

		public override void Init()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			messages = new Queue<Message>();
			prefabsManager_.Load("PopUpMessagePrefabsHolder");
			hierarchy_ = prefabsManager_.Instantiate<PopUpHierarchy>("PopUpPanel");
			hierarchy_.panel.depth = 1100;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public override void OnReset()
		{
			while (messages.Count > 0)
			{
				Message mes = messages.Dequeue();
				Destroy(mes);
			}
		}

		public override void OnDataLoaded()
		{
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			ClearMessages();
		}

		private void ClearMessages()
		{
			int num = 0;
			Message[] array = messages.ToArray();
			for (int num2 = array.Length - 1; num2 >= 0; num2--)
			{
				Message message = array[num2];
				if (!message.dead && !message.dies && num > mesagesLimit)
				{
					message.dies = true;
					message.sequence.Goto(messageLifeTime - messageFadeTime, true);
				}
				num++;
			}
			while (messages.Count > 0)
			{
				Message message2 = messages.Peek();
				if (message2.dead)
				{
					messages.Dequeue();
					Destroy(message2);
					continue;
				}
				break;
			}
		}

		private static void Destroy(Message mes)
		{
			if (mes.sequence != null)
			{
				mes.sequence.Kill();
			}
			if (mes.stepTween != null)
			{
				mes.stepTween.Kill();
			}
			Object.Destroy(mes.message.gameObject);
		}

		public void AddMessage(string text)
		{
			AddMessage(text, normalMessageColor);
		}

		public void AddWarningMessage(string text)
		{
			AddMessage(text, warningMessageColor);
		}

		public void AddMessage(string text, Color color)
		{
			AddMessage(text, 60, color);
		}

		public void AddMessage(string text, int fontSize)
		{
			AddMessage(text, fontSize, normalMessageColor);
		}

		public void AddMessage(string text, int fontSize, Color color)
		{
			if (fontSize == 0)
			{
				fontSize = 60;
			}
			Color32 color2 = color;
			string arg = string.Format("{0:X02}{1:X02}{2:X02}", color2.r, color2.g, color2.b);
			string text2 = string.Format("[{0}]{1}[-]", arg, text);
			Message message = CreateMessage(text2, fontSize);
			MakeTween(message);
			MoveMessages();
			messages.Enqueue(message);
		}

		private void MoveMessages()
		{
			Message[] array = messages.ToArray();
			for (int i = 0; i < array.Length; i++)
			{
				MakeStepTween(array[i]);
			}
		}

		private Message CreateMessage(string text, int fontSize)
		{
			Message message = new Message();
			message.message = Object.Instantiate(hierarchy_.message);
			message.message.text = text;
			message.message.fontSize = fontSize;
			message.message.transform.localScale = Vector3.one;
			message.message.gameObject.SetActive(true);
			message.trans = message.message.transform;
			message.trans.SetParent(hierarchy_.panel.transform);
			message.trans.localPosition = new Vector3(0f, startHeight, 0f);
			message.trans.localScale = Vector3.one;
			return message;
		}

		private void MakeTween(Message m)
		{
			m.message.color = Color.clear;
			m.sequence = DOTween.Sequence();
			m.sequence.Insert(0f, DOTween.To(() => m.message.color, delegate(Color v)
			{
				m.message.color = v;
			}, Color.white, messageFadeTime).SetEase(Ease.InOutQuad));
			m.sequence.Insert(messageLifeTime - messageFadeTime, DOTween.To(() => m.message.color, delegate(Color v)
			{
				m.message.color = v;
			}, Color.clear, messageFadeTime).SetEase(Ease.InOutQuad));
			m.sequence.InsertCallback(messageLifeTime, delegate
			{
				m.dead = true;
			});
			m.sequence.Play();
		}

		private void MakeStepTween(Message m)
		{
			if (m.stepTween != null)
			{
				m.stepTween.Kill();
			}
			m.targetStep++;
			Vector3 zero = Vector3.zero;
			zero.y += startHeight + (float)m.targetStep * step;
			m.stepTween = DOTween.To(() => m.trans.localPosition, delegate(Vector3 v)
			{
				m.trans.localPosition = v;
			}, zero, messageFadeTime).SetEase(Ease.OutQuad);
		}
	}
}
