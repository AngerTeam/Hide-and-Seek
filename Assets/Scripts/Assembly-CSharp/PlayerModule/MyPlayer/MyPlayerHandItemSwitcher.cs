using System;
using Extensions;
using Animations;
using ArticulView;
using ArticulViewModule;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyEngine.Utils.Unity;
using DG.Tweening;
using InventoryModule;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerHandItemSwitcher : AnimatedItemView
	{
		private int nextArticulId_;

		private GameObject switchItemContainer_;

		private ArtikulItemViewManager selector_;

		private Sequence switchSequence_;

		private bool disposed_;

		private MyPlayerStatsModel playerModel_;

		private bool renderPedning_;

		private UnityEvent unityEvent_;

		public ArticulViewBase ArticulView { get; private set; }

		public GameObject ItemContainer { get; private set; }

		public event Action ItemChanged;

		public MyPlayerHandItemSwitcher(GameObject switchItemContainer, GameObject itemContainer)
		{
			switchItemContainer_ = switchItemContainer;
			ItemContainer = itemContainer;
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			SingletonManager.Get<ArtikulItemViewManager>(out selector_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			MakeSwitchSequence();
			type = AnimationType.FirstPersonItem;
			InitAsc();
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			if (renderPedning_)
			{
				SwitchArticulView();
			}
		}

		public override void Dispose()
		{
			disposed_ = true;
			switchSequence_.Kill();
			switchSequence_ = null;
			if (ArticulView != null)
			{
				ArticulView.Dispose();
			}
			ArticulView = null;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			base.Dispose();
		}

		internal void SwitchItem(int articulId)
		{
			switchSequence_.Rewind();
			switchSequence_.Play();
			nextArticulId_ = articulId;
		}

		private void MakeSwitchSequence()
		{
			switchSequence_ = DOTween.Sequence();
			switchSequence_.SetAutoKill(false);
			Vector3 localPosition = switchItemContainer_.transform.localPosition;
			localPosition.y -= 0.3f;
			Vector3 localPosition2 = switchItemContainer_.transform.localPosition;
			float num = 0.15f;
			float duration = 0.15f;
			switchSequence_.Insert(0f, DOTween.To(() => switchItemContainer_.transform.localPosition, delegate(Vector3 p)
			{
				switchItemContainer_.transform.localPosition = p;
			}, localPosition, num).SetEase(Ease.InQuad));
			switchSequence_.Insert(num, DOTween.To(() => switchItemContainer_.transform.localPosition, delegate(Vector3 p)
			{
				switchItemContainer_.transform.localPosition = p;
			}, localPosition2, duration).SetEase(Ease.OutQuad));
			switchSequence_.InsertCallback(num * 0.5f, SwitchArticulView);
			switchSequence_.Goto(0f);
		}

		private void SwitchArticulView()
		{
			if (disposed_)
			{
				return;
			}
			ItemContainer.transform.localPosition = Vector3.zero;
			if (ArticulView != null)
			{
				ArticulView.Dispose();
			}
			if (!playerModel_.myVisibility.Visible)
			{
				renderPedning_ = true;
				return;
			}
			renderPedning_ = false;
			SoundProvider.PlaySingleSound2D(16);
			ArticulView = selector_.GetRenderer(nextArticulId_);
			ArticulView.isPlayer = true;
			ArticulView.Render(ItemContainer.transform, nextArticulId_);
			if (!(ArticulView.Container != null))
			{
				return;
			}
			GameObjectUtils.SetLayer(ArticulView.Container, 9);
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(nextArticulId_, out value))
			{
				Vector3 vector = Vector3.zero;
				ArtikulModelsEntries value2;
				if (ArticulViewContentMap.ArtikulModels.TryGetValue(value.model_id, out value2))
				{
					vector = Vector3Utils.SafeParse(value2.offset_first_person);
				}
				if (vector == Vector3.zero)
				{
					vector = Vector3Utils.SafeParse(value.offset_in_hand);
				}
				ItemContainer.transform.localPosition = vector;
			}
			QueueManager queueManager = SingletonManager.Get<QueueManager>();
			queueManager.AddTask(LoadAnimations);
			queueManager.AddTask(this.ItemChanged.SafeInvoke);
		}

		private void LoadAnimations()
		{
			if (selectedArtikul != null && ArticulView != null && ArticulView.Instance != null)
			{
				LoadAnimations(ArticulView.Instance);
			}
		}
	}
}
