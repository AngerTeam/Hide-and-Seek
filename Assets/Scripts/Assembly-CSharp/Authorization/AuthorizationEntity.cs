using System;
using AuthorizationGame;
using CraftyEngine.Infrastructure;
using CraftyEngine.States;
using CraftyEngine.Utils;
using ExceptionsModule;
using Extensions;
using GameInfrastructure;
using HttpNetwork;

namespace Authorization
{
	public class AuthorizationEntity : Singleton
	{
		private AuthorizationModel authModel_;

		private AuthServerOnlineController authServerController_;

		private AuthorizationData data_;

		private GameServerOnlineController gameServerController_;

		private UnityTimer pingTimer_;

		private UnityTimerManager timerManager_;

		private int tries_;

		private UnityEvent unityEvent_;

		private ExceptionsManager exceptionsManager_;

		public ProgressableStateMachine StateMachine { get; private set; }

		public event Action Succeed;

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			StateMachine.Dispose();
			StateMachine = null;
			if (pingTimer_ != null)
			{
				pingTimer_.Stop();
			}
		}

		public override void Init()
		{
			SingletonManager.Get<AuthorizationModel>(out authModel_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
			tries_ = 0;
			exceptionsManager_.AddHandler(HandleErrored, 600, 601, 602, 1000, 1001);
			authModel_.authServerUrl = "https://hns.pixelgun.plus/auth/";
			string typeName = "PersistanceUserData.cfg";
			if (PersistanceManager.Exists<AuthorizationData>(typeName))
			{
				PersistanceManager.Get<AuthorizationData>(typeName, out data_);
			}
			else
			{
				PersistanceManager.Get<AuthorizationData>("AuthorizationData.cfg", out data_);
			}
			if (!string.IsNullOrEmpty(data_.login) && !string.IsNullOrEmpty(data_.password))
			{
				authModel_.registered = true;
			}
			authServerController_ = new AuthServerOnlineController();
			gameServerController_ = new GameServerOnlineController();
			State state = new ProgressState("desidion", 0f);
			State state2 = new ProgressState("register", 0.2f);
			State state3 = new ProgressState("login", 0.2f);
			State state4 = new ProgressState("getServers", 0.3f);
			State state5 = new ProgressState("serverEnter", 0.5f);
			State state6 = new ProgressState("persCreate", 0.6f);
			State state7 = new ProgressState("persEnter", 0.7f);
			State state8 = new ProgressState("checkPvp", 0.8f);
			State state9 = new ProgressState("sync", 0.9f);
			State state10 = new ProgressState("success", 1f);
			state.AddTransaction(state2, () => !authModel_.registered);
			state.AddTransaction(state3, () => authModel_.registered);
			state2.AddTransaction(state4, () => authModel_.HasSession);
			state3.AddTransaction(state4, () => authModel_.HasSession);
			state4.AddTransaction(state5, () => authModel_.HasServerList);
			state5.AddTransaction(state7, () => authModel_.HasGameServer && authModel_.HasPers);
			state5.AddTransaction(state6, () => authModel_.HasGameServer);
			state6.AddTransaction(state7, () => authModel_.HasGameServer && authModel_.HasPers);
			state7.AddTransaction(state8, () => authModel_.persEntered && !authModel_.checkCompleted);
			state7.AddTransaction(state9, () => authModel_.persEntered && authModel_.checkCompleted);
			state8.AddTransaction(state9, () => authModel_.checkCompleted && !authModel_.alreadyInPvp);
			state9.AddTransaction(state10, () => authModel_.HasSyncMessage);
			state8.AddTransaction(state10, () => authModel_.checkCompleted && authModel_.alreadyInPvp);
			state2.Entered += authServerController_.SendRegistrationGuest;
			state2.Exited += SaveRegistrationInformation;
			state8.Entered += gameServerController_.SendCheckPvp;
			state3.Entered += SendLogin;
			state4.Entered += SendServer;
			state5.Entered += SendServerEnter;
			state6.Entered += gameServerController_.SendPersCreate;
			state7.Entered += gameServerController_.SendPersEnter;
			state9.Entered += gameServerController_.SendSync;
			state10.Entered += ReportSuccess;
			StateMachine = new ProgressableStateMachine(state, "Authorization");
			StateMachine.StateMachine.SetModel<AuthModelInspector>(authModel_);
			StateMachine.Weight = 5f;
			pingTimer_ = timerManager_.SetTimer(300f);
			pingTimer_.repeat = true;
			pingTimer_.Completeted += SendPing;
		}

		public void Sync()
		{
			gameServerController_.SendSync();
		}

		public void Login()
		{
			authModel_.started = true;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			unityEvent_.Subscribe(UnityEventType.ApplicationFocus, HandleFocus);
		}

		private void HandleFocus()
		{
			SendPing();
		}

		public void SendNickname(string nickname)
		{
			gameServerController_.SendSetNickname(nickname);
			authModel_.HasNickname = true;
		}

		private bool HandleErrored(ExceptionArgs args)
		{
			HttpCommandTask httpCommandTask = args.context as HttpCommandTask;
			if (httpCommandTask == null)
			{
				return false;
			}
			if (authModel_.result == AuthorisationResult.Undefined)
			{
				tries_++;
				if (tries_ == 3)
				{
					Exc.Report(3301, null, httpCommandTask.error);
					return true;
				}
				StateMachine.StateMachine.ReenterState();
				return true;
			}
			int id = args.Id;
			if (id == 1000)
			{
				if (httpCommandTask.error.Contains("already started"))
				{
					return true;
				}
				if (httpCommandTask.error.Contains("already binded"))
				{
					return true;
				}
			}
			return false;
		}

		private void ReportSuccess()
		{
			StateMachine.Enabled = false;
			this.Succeed.SafeInvoke();
		}

		private void SaveRegistrationInformation()
		{
			if (authModel_.registrationGuest != null)
			{
				data_.registrationTimestamp = authModel_.registrationTimestamp;
				data_.login = authModel_.registrationGuest.email;
				data_.password = authModel_.registrationGuest.passwd;
				PersistanceManager.Save(data_);
				authModel_.newUser = true;
			}
		}

		private void SendLogin()
		{
			authServerController_.SendLogin(data_.login, data_.password);
		}

		private void SendPing()
		{
			if (authModel_.HasSession)
			{
				gameServerController_.SendPing();
			}
		}

		private void SendServer()
		{
			authServerController_.SendGetServers();
			HttpOnlineModel singlton;
			SingletonManager.Get<HttpOnlineModel>(out singlton);
			LogReporterModel.info["user_id"] = singlton.userId.ToString();
			LogReporterModel.info["login"] = data_.login;
		}

		private void SendServerEnter()
		{
			authServerController_.SendDefaultServerEnter();
		}

		private void Update()
		{
			if (StateMachine != null)
			{
				StateMachine.Update();
			}
		}
	}
}
