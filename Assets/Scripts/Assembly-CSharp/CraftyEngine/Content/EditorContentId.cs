using UnityEngine;

namespace CraftyEngine.Content
{
	public class EditorContentId : MonoBehaviour
	{
		[Header("Описание сущности")]
		public string entryName;

		public int id;

		public string fieldName;

		[Space(15f)]
		[Header("Заменить на объект")]
		public string meta;

		public Object unityObject;

		[Header("Заменить на значение")]
		[Space(15f)]
		public string stringValue;

		public string floatValue;

		public string intValue;
	}
}
