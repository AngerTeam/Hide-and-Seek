using System;
using CraftyBundles;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Utils.Unity;
using UnityEngine;

namespace ShapesModule
{
	public class ShapeInstance : IDisposable
	{
		public FileHolder fileHolder;

		public int id;

		public GameObject shapeObject;

		public int typeId;

		private float bigColliderSize = 2.5f;

		private Collider[] colliders_;

		private string currentAnimationState_;

		private float defaultColliderSize = 1f;

		private bool useBigCollider_;

		public bool Active
		{
			get
			{
				return shapeObject != null && shapeObject.activeSelf;
			}
			set
			{
				SetActive(value);
			}
		}

		public GameObject Container { get; private set; }

		public ShapeInstanceEntries IslandObject { get; private set; }

		public Transform Transform { get; private set; }

		public ShapeInstance(GameObject gameObject)
		{
			Container = gameObject;
			Transform = gameObject.transform;
			Shape shape = Container.AddComponent<Shape>();
			shape.instance = this;
		}

		public void AddObject(FileHolder fholder)
		{
			if (fholder != null && shapeObject != null)
			{
				GameObject instance;
				RenderHierarchyUtils.TryInstansiate(fholder, out instance);
				if (!(instance == null))
				{
					instance.transform.SetParent(shapeObject.transform);
					instance.transform.localPosition = Vector3.zero;
					instance.transform.localRotation = Quaternion.identity;
				}
			}
		}

		public void Animate(string animationName)
		{
			currentAnimationState_ = animationName;
			if (shapeObject != null)
			{
				Animation componentInChildren = shapeObject.GetComponentInChildren<Animation>();
				if (componentInChildren != null)
				{
					componentInChildren.Play(animationName);
				}
			}
		}

		public bool CheckCollision(Vector3 point)
		{
			if (colliders_ != null)
			{
				for (int i = 0; i < colliders_.Length; i++)
				{
					if (colliders_[i] != null && colliders_[i].bounds.Contains(point))
					{
						return true;
					}
				}
			}
			return false;
		}

		public void SetId(int id)
		{
			this.id = id;
		}

		public void SetId(ShapeInstanceEntries islandObjectEntries)
		{
			id = islandObjectEntries.id;
			IslandObject = islandObjectEntries;
			useBigCollider_ = islandObjectEntries.bigCollider;
		}

		public void SetLayer(bool isPassable)
		{
			GameObjectUtils.SetLayer(Container, (!isPassable) ? 12 : 11);
		}

		public void SetLoopAnimation()
		{
			if (shapeObject != null)
			{
				Animation componentInChildren = shapeObject.GetComponentInChildren<Animation>();
				if (componentInChildren != null)
				{
					componentInChildren.wrapMode = WrapMode.Loop;
				}
			}
		}

		public void SetNameAndLayer(string name)
		{
			Container.name = "shape:" + name;
			if (IslandObject != null)
			{
				SetLayer(IslandObject.isPassable);
			}
		}

		public override string ToString()
		{
			return string.Format("Shape {0}: {1}", Container.name, id);
		}

		public void Dispose()
		{
			UnityEngine.Object.Destroy(Container);
		}

		public void UpdateColliders()
		{
			if (colliders_ == null)
			{
				colliders_ = Container.GetComponentsInChildren<Collider>();
			}
			if (colliders_.Length == 0)
			{
				GenerateDefaultCollider();
			}
		}

		private void GenerateDefaultCollider()
		{
			BoxCollider boxCollider = Container.AddComponent<BoxCollider>();
			boxCollider.size = new Vector3(defaultColliderSize, defaultColliderSize, defaultColliderSize);
			if (useBigCollider_)
			{
				BoxCollider boxCollider2 = Container.AddComponent<BoxCollider>();
				boxCollider2.size = new Vector3(bigColliderSize, bigColliderSize, bigColliderSize);
				colliders_ = new Collider[2] { boxCollider, boxCollider2 };
			}
			else
			{
				colliders_ = new Collider[1] { boxCollider };
			}
		}

		private void SetActive(bool value)
		{
			if (shapeObject != null)
			{
				shapeObject.SetActive(value);
				if (!string.IsNullOrEmpty(currentAnimationState_) && value)
				{
					Animate(currentAnimationState_);
				}
			}
		}
	}
}
