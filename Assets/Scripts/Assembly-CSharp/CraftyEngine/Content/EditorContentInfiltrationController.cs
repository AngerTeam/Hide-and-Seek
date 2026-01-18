using System.Collections.Generic;
using Interlace.Amf;
using UnityEngine;

namespace CraftyEngine.Content
{
	public class EditorContentInfiltrationController : Singleton
	{
		private ContentLoaderModel model_;

		private Dictionary<string, EditorContentId> unityObjects_;

		public override void Init()
		{
			SingletonManager.Get<ContentLoaderModel>(out model_);
			model_.Loaded += HandleLoaded;
		}

		public bool TryGetUnityObject(string value, out Object obj, out string meta)
		{
			meta = null;
			obj = null;
			EditorContentId value2;
			if (unityObjects_.TryGetValue(value, out value2))
			{
				obj = value2.unityObject;
				meta = value2.meta;
				return true;
			}
			foreach (KeyValuePair<string, EditorContentId> item in unityObjects_)
			{
				if (value.EndsWith(item.Key))
				{
					obj = item.Value.unityObject;
					meta = item.Value.meta;
					return true;
				}
			}
			return false;
		}

		private void HandleLoaded()
		{
			unityObjects_ = new Dictionary<string, EditorContentId>();
			EditorContentId[] array = Object.FindObjectsOfType<EditorContentId>();
			EditorContentId[] array2 = array;
			foreach (EditorContentId editorContentId in array2)
			{
				if (editorContentId.unityObject != null)
				{
					editorContentId.stringValue = "#" + editorContentId.unityObject;
					unityObjects_[editorContentId.stringValue] = editorContentId;
				}
				object value;
				if (!model_.associativeElements.TryGetValue(editorContentId.entryName, out value))
				{
					continue;
				}
				AmfArray amfArray = value as AmfArray;
				if (amfArray == null || amfArray.DenseElements.Count <= editorContentId.id)
				{
					continue;
				}
				foreach (object denseElement in amfArray.DenseElements)
				{
					AmfArray amfArray2 = denseElement as AmfArray;
					if (amfArray2 != null)
					{
						int num = (int)amfArray2.AssociativeElements["id"];
						if (num == editorContentId.id)
						{
							Infiltrate(editorContentId, amfArray2);
						}
					}
				}
			}
		}

		private static void Infiltrate(EditorContentId contentId, AmfArray amdEntry)
		{
			if (!string.IsNullOrEmpty(contentId.stringValue))
			{
				amdEntry.AssociativeElements[contentId.fieldName] = contentId.stringValue;
			}
			else if (!string.IsNullOrEmpty(contentId.intValue))
			{
				amdEntry.AssociativeElements[contentId.fieldName] = int.Parse(contentId.intValue);
			}
			else if (!string.IsNullOrEmpty(contentId.floatValue))
			{
				amdEntry.AssociativeElements[contentId.fieldName] = float.Parse(contentId.floatValue);
			}
		}
	}
}
