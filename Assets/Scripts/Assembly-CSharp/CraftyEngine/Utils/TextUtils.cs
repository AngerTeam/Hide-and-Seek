using System;
using System.Text;
using System.Text.RegularExpressions;

namespace CraftyEngine.Utils
{
	public class TextUtils
	{
		private static readonly string english = "[A-Za-z\\d\\_\\-\\s]+";

		public static string ToCamelCase(string input, bool firstLetterUpperCase = true)
		{
			if (input == null)
			{
				return null;
			}
			int num = 0;
			while (num < input.Length - 1)
			{
				char c = input[num];
				char c2 = input[num + 1];
				num++;
				if (char.IsLetter(c) && char.IsLetter(c2) && char.IsLower(c) && char.IsUpper(c2))
				{
					input = input.Insert(num, "_");
				}
			}
			string[] array = input.Split(new char[7] { '`', '<', '>', '.', ' ', '-', '_' }, StringSplitOptions.RemoveEmptyEntries);
			StringBuilder stringBuilder = new StringBuilder();
			string[] array2 = array;
			foreach (string text in array2)
			{
				string text2 = text.Substring(0, 1);
				string text3 = text.Substring(1, text.Length - 1).ToLower();
				if (!firstLetterUpperCase)
				{
					firstLetterUpperCase = true;
					stringBuilder.Append(text2.ToLower() + text3);
				}
				else
				{
					stringBuilder.Append(text2.ToUpper() + text3);
				}
			}
			return stringBuilder.ToString();
		}

		public static string CamelCaseToUpperUnderscore(string CamelCase)
		{
			string text = Regex.Replace(CamelCase, "([A-Z])", "_$0", (RegexOptions)8);
			if (text.StartsWith("_"))
			{
				text = text.Substring(1);
			}
			return text.ToUpper();
		}

		public static string GetActionName(Action action)
		{
			if (action.Method.DeclaringType != null)
			{
				return string.Format("{0}.{1}", action.Method.DeclaringType.Name, action.Method.Name);
			}
			return null;
		}

		public static string GetEnglishOnly(string source)
		{
			Regex regex = new Regex(english);
			MatchCollection matchCollection = regex.Matches(source);
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < matchCollection.Count; i++)
			{
				stringBuilder.Append(matchCollection[i].Value);
			}
			return stringBuilder.ToString();
		}

		public static string FirstLetterToLowerCase(string line)
		{
			if (string.IsNullOrEmpty(line))
			{
				return line;
			}
			return char.ToLowerInvariant(line[0]) + line.Substring(1);
		}
	}
}
