using System;
using InventoryModule;
using UnityEngine;

namespace InventoryViewModule
{
	public class SlotController : IDisposable
	{
		private bool disposed_;

		private UIDragScrollView dragScrollView_;

		private bool scrollViewEmptyOnly_;

		public bool LockDrag { get; private set; }

		public SlotModel Model { get; private set; }

		public SlotView View { get; private set; }

		public SlotController(SlotViewType type, SlotModel model)
		{
			Model = model;
			View = new SlotView(type);
			View.Hierarchy.slot = this;
			SingletonManager.Get<SlotsUpdateManager>().Register(this);
			Dirtyfy();
		}

		public void Dirtyfy()
		{
			Model.Dirty = true;
		}

		public void Dispose()
		{
			if (!disposed_)
			{
				View.Dispose();
				disposed_ = true;
			}
		}

		public void HideItem()
		{
			if (!disposed_)
			{
				if (Model.GhostItem == null)
				{
					View.ReadItem(null);
				}
				else
				{
					View.ReadItem(Model.GhostItem);
				}
				UpdateScrollView();
			}
		}

		public void Move(Vector2 position)
		{
			if (!disposed_)
			{
				View.Container.transform.localPosition = position;
			}
		}

		public void Redraw()
		{
			if (disposed_)
			{
				return;
			}
			if (Model.IsEmpty)
			{
				if (Model.GhostItem == null)
				{
					View.ReadItem(null);
				}
				else
				{
					View.ghost = Model.transparentAsGhost;
					View.ReadItem(Model.GhostItem);
				}
			}
			else
			{
				View.ghost = false;
				View.ReadItem(Model.Item);
			}
			UpdateScrollView();
		}

		public void Select(bool value)
		{
			if (!disposed_)
			{
				View.Hierarchy.selectionBorderA.gameObject.SetActive(value);
			}
		}

		public void SetBindKey(int i)
		{
			if (!disposed_)
			{
				View.SetBindKey(i.ToString());
			}
		}

		public void SetInteractable(bool value)
		{
			if (!disposed_)
			{
				Model.Interactable = value;
				View.Hierarchy.GetComponent<BoxCollider>().enabled = value;
			}
		}

		public void SetParent(Transform parent)
		{
			if (!disposed_)
			{
				View.Container.transform.SetParent(parent, false);
				View.Container.transform.localPosition = Vector3.zero;
			}
		}

		public void SetScrollView(UIScrollView scrollView, bool emptyOnly)
		{
			if (!disposed_)
			{
				scrollViewEmptyOnly_ = emptyOnly;
				dragScrollView_ = View.Hierarchy.GetComponent<UIDragScrollView>();
				if (dragScrollView_ == null)
				{
					dragScrollView_ = View.Hierarchy.gameObject.AddComponent<UIDragScrollView>();
				}
				dragScrollView_.scrollView = scrollView;
				UpdateScrollView();
			}
		}

		public void SetVisible(bool value)
		{
			if (!disposed_)
			{
				View.Container.gameObject.SetActive(value);
			}
		}

		public void Split(bool value)
		{
			if (!disposed_)
			{
				View.Hierarchy.selectionBorderB.gameObject.SetActive(value);
			}
		}

		private void UpdateScrollView()
		{
			if (dragScrollView_ != null)
			{
				LockDrag = !scrollViewEmptyOnly_ || Model.IsEmpty;
				dragScrollView_.enabled = LockDrag;
			}
			else
			{
				LockDrag = false;
			}
		}
	}
}
