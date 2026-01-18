namespace Interlace.Amf
{
	public class AmfTraits
	{
		private readonly string _className;

		private readonly AmfTraitsKind _kind;

		private readonly string[] _memberNames;

		public string ClassName
		{
			get
			{
				return _className;
			}
		}

		public AmfTraitsKind Kind
		{
			get
			{
				return _kind;
			}
		}

		public string[] MemberNames
		{
			get
			{
				return _memberNames;
			}
		}

		public AmfTraits(string className, AmfTraitsKind kind, string[] memberNames)
		{
			_className = className;
			_kind = kind;
			_memberNames = memberNames;
		}

		public override bool Equals(object obj)
		{
			AmfTraits amfTraits = obj as AmfTraits;
			if (_className != amfTraits._className)
			{
				return false;
			}
			if (_kind != amfTraits._kind)
			{
				return false;
			}
			if (_memberNames == null != (amfTraits._memberNames == null))
			{
				return false;
			}
			if (_memberNames == null)
			{
				return true;
			}
			if (_memberNames.Length != amfTraits._memberNames.Length)
			{
				return false;
			}
			for (int i = 0; i < _memberNames.Length; i++)
			{
				if (!object.Equals(_memberNames[i], amfTraits._memberNames[i]))
				{
					return false;
				}
			}
			return true;
		}

		public override int GetHashCode()
		{
			int num = _className.GetHashCode() ^ _kind.GetHashCode();
			string[] memberNames = _memberNames;
			foreach (string text in memberNames)
			{
				num ^= text.GetHashCode();
			}
			return num;
		}
	}
}
