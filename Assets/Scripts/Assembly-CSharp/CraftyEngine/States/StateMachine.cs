using System;
using System.Collections.Generic;
using System.Text;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;

namespace CraftyEngine.States
{
	public class StateMachine : IDisposable
	{
		private static List<StateMachine> allStateMachines_ = new List<StateMachine>();

		public bool enabled;

		public bool enableLog;

		public bool instantUpdate;

		private string name_;

		private UnityEvent unityEvent_;

		public State AnyState { get; private set; }

		public State CurrentState { get; private set; }

		public StateMachineEditorView EditorView { get; private set; }

		public event Action StateChanged;

		public StateMachine(State initialState, string name, bool addToStats = true)
		{
			if (addToStats)
			{
				allStateMachines_.Add(this);
			}
			name_ = name;
			AnyState = new State("Any");
			CurrentState = initialState;
			instantUpdate = true;
			enabled = true;
			if (!CompileConstants.EDITOR || !Application.isPlaying)
			{
				return;
			}
			EditorView = new GameObject
			{
				name = name
			}.AddComponent<StateMachineEditorView>();
			EditorView.SetStateMachine(this);
			GameObject gameObject = GameObject.Find("StateMachines");
			if (gameObject == null)
			{
				gameObject = new GameObject("StateMachines");
				if (Application.isPlaying)
				{
					UnityEngine.Object.DontDestroyOnLoad(gameObject);
				}
			}
			EditorView.transform.SetParent(gameObject.transform);
		}

		public static string GetAllStateMachinesList()
		{
			StringBuilder stringBuilder = new StringBuilder();
			foreach (StateMachine item in allStateMachines_)
			{
				string value = string.Format("[{0}]: {1}", item.name_, item.CurrentState.Name);
				stringBuilder.AppendLine(value);
			}
			return stringBuilder.ToString();
		}

		public void Dispose()
		{
			enabled = false;
			if (allStateMachines_.Contains(this))
			{
				allStateMachines_.Remove(this);
			}
			if (unityEvent_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			}
		}

		public void ReenterState()
		{
			GoTo(CurrentState);
		}

		public void GoTo(State state, bool supressEvents = false)
		{
			if (!supressEvents && CurrentState != null)
			{
				CurrentState.Exit();
			}
			CurrentState = state;
			this.StateChanged.SafeInvoke();
			CurrentState.Enter();
			if (instantUpdate)
			{
				Update();
			}
		}

		public void SetAutoUpdate(int layer)
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_, layer);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public void SetModel<T>(object model) where T : MonoBehaviour, IModelInspector
		{
			if (CompileConstants.EDITOR && Application.isPlaying)
			{
				T val = EditorView.gameObject.AddComponent<T>();
				val.Model = model;
			}
		}

		public void Update()
		{
			Update(0);
		}

		private bool TryTransaction(Transaction transaction, int depth)
		{
			if (transaction != null)
			{
				transaction.Start();
				CurrentState.Exit();
				transaction.Transit();
				if (enableLog)
				{
					Log.Info("State machine [{0}]: change state from [{1}] to [{2}]", name_, CurrentState.Name, transaction.Target.Name);
				}
				CurrentState = transaction.Target;
				this.StateChanged.SafeInvoke();
				CurrentState.Enter();
				transaction.Complete();
				if (instantUpdate)
				{
					Update(depth);
				}
				return true;
			}
			return false;
		}

		private void Update(int depth)
		{
			if (enabled)
			{
				depth++;
				if (depth >= 10)
				{
					throw new StackOverflowException();
				}
				Transaction transaction = CurrentState.TryGetExitTransaction();
				if (!TryTransaction(transaction, depth))
				{
					transaction = AnyState.TryGetExitTransaction();
					TryTransaction(transaction, depth);
				}
			}
		}
	}
}
