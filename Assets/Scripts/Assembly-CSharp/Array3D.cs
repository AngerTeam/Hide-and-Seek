using System;

public class Array3D<T>
{
	private T[] array;

	public int Length { get; private set; }

	public int xSize { get; private set; }

	public int ySize { get; private set; }

	public int zSize { get; private set; }

	public T this[int i]
	{
		get
		{
			return Get(i);
		}
		set
		{
			Set(i, value);
		}
	}

	public Array3D(int sx, int sy, int sz)
	{
		xSize = sx;
		ySize = sy;
		zSize = sz;
		Length = sx * sy * sz;
		array = new T[Length];
	}

	public T Get(int index)
	{
		return array[index];
	}

	public T Get(int x, int y, int z)
	{
		validIndex(x, y, z);
		return Get(xyz2index(x, y, z));
	}

	public void index2xyz(int index, out int x, out int y, out int z)
	{
		x = index % zSize;
		index /= zSize;
		y = index % ySize;
		index /= ySize;
		z = index;
	}

	public void Set(int index, T value)
	{
		array[index] = value;
	}

	public void Set(int x, int y, int z, T value)
	{
		validIndex(x, y, z);
		array[xyz2index(x, y, z)] = value;
	}

	public int xyz2index(int x, int y, int z)
	{
		return z + zSize * (y + ySize * x);
	}

	private void validIndex(int x, int y, int z)
	{
		if (x < 0 && x >= xSize && y < 0 && y >= ySize && z < 0 && z >= zSize)
		{
			throw new IndexOutOfRangeException(string.Format("unable to set value at {0} {1} {2}", x, y, z));
		}
	}
}
