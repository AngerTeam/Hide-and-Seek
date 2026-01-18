using System;
using UnityEngine;

namespace ShapesModule
{
	public class ShapeEventArgs : EventArgs
	{
		public Vector2 Point;

		public int ShapeId { get; private set; }

		public ShapeInstance Shape { get; private set; }

		public ShapeEventArgs(ShapeInstance shape)
		{
			Shape = shape;
			ShapeId = shape.id;
		}

		public ShapeEventArgs(ShapeInstance shape, Vector2 point)
		{
			Shape = shape;
			ShapeId = shape.id;
			Point = point;
		}
	}
}
