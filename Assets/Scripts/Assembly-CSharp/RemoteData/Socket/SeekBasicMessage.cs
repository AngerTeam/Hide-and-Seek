using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SeekBasicMessage : PurchaseMessage
	{
		public int x;

		public int y;

		public int z;

		public string target;

		public int damage;

		public int health;

		public MemberMessage[] membersUpdate;

		public SeekBasicMessage(string target, int damage, int health, IIntVector3 vector)
		{
			this.target = target;
			this.damage = damage;
			this.health = health;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
		}

		public SeekBasicMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			x = Get<int>(source, "x", false);
			y = Get<int>(source, "y", false);
			z = Get<int>(source, "z", false);
			target = Get<string>(source, "target", false);
			damage = Get<int>(source, "damage", false);
			health = Get<int>(source, "health", false);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("SeekBasicMessage: x: {0}; y: {1}; z: {2}; target: {3}; damage: {4}; health: {5};\n membersUpdate: {6}", x, y, z, target, damage, health, ArrayUtils.ArrayToString(membersUpdate, "\n\t")) + base.ToString();
		}
	}
}
