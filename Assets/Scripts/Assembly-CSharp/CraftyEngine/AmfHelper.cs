using System.Collections.Generic;
using System.IO;
using Interlace.Amf;
using Interlace.Amf.Extended;

namespace CraftyEngine
{
	public static class AmfHelper
	{
		private static AmfRegistry registery = new AmfRegistry();

		private static OptAmfRegistry optAmfRegistry = new OptAmfRegistry();

		public static byte[] Write(AmfObject amfObject)
		{
			return AmfWriter.Write(registery, amfObject);
		}

		public static AmfArray ReadArray(Stream stream)
		{
			object obj = AmfReader.Read(registery, stream);
			return CheckForAmfArray(obj);
		}

		public static AmfArray ReadArray(byte[] data)
		{
			object obj = AmfReader.Read(registery, data);
			return CheckForAmfArray(obj);
		}

		public static AmfObject ReadObject(Stream stream)
		{
			object obj = AmfReader.Read(registery, stream);
			return CheckForAmfObject(obj);
		}

		public static AmfObject ReadObjectOpt(byte[] data)
		{
			object obj = OptAmfReader.Read(optAmfRegistry, data);
			return CheckForAmfObject(obj);
		}

		public static AmfObject ReadObject(byte[] data)
		{
			object obj = AmfReader.Read(registery, data);
			return CheckForAmfObject(obj);
		}

		public static AmfArray CheckForAmfArray(object obj)
		{
			if (obj != null)
			{
				AmfArray amfArray = obj as AmfArray;
				if (amfArray != null)
				{
					return amfArray;
				}
				Log.Error("Wrong format!");
			}
			return null;
		}

		public static bool TryCastToArray(object source, out AmfArray amfObj)
		{
			amfObj = source as AmfArray;
			return amfObj != null;
		}

		public static bool TryCastToObject(object source, out AmfObject amfObj)
		{
			amfObj = source as AmfObject;
			return amfObj != null;
		}

		public static AmfObject CheckForAmfObject(object obj)
		{
			if (obj != null)
			{
				AmfObject amfObject = obj as AmfObject;
				if (amfObject != null)
				{
					return amfObject;
				}
				Log.Error("Wrong format!");
			}
			return null;
		}

		public static bool TryGet<T>(AmfObject amf, string key, out T value)
		{
			if (amf == null)
			{
				Log.Warning("AMF is null!");
			}
			if (amf.Properties.ContainsKey(key))
			{
				try
				{
					value = (T)amf.Properties[key];
					return true;
				}
				catch
				{
				}
			}
			value = default(T);
			return false;
		}

		public static string AmfToString(AmfArray amfArray)
		{
			return AmfToJson(amfArray).ToString(true);
		}

		public static string AmfToString(AmfObject amfObject)
		{
			return AmfToJson(amfObject).ToString(true);
		}

		public static JSONObject AmfToJson(AmfArray amfArray)
		{
			JSONObject jSONObject = new JSONObject();
			bool flag = false;
			if (amfArray.AssociativeElements.Count > 0)
			{
				JSONObject jSONObject2 = new JSONObject();
				jSONObject.AddField("AssociativeElements", jSONObject2);
				AddToString(amfArray.AssociativeElements, jSONObject2);
				flag = true;
			}
			if (amfArray.DenseElements.Count > 0)
			{
				JSONObject jSONObject3 = new JSONObject();
				jSONObject.AddField("DenseElements", jSONObject3);
				AddToString(amfArray.DenseElements, jSONObject3);
				flag = true;
			}
			if (!flag)
			{
				jSONObject.AddField("AmfArray", "Empty");
			}
			return jSONObject;
		}

		private static void AddToString(IList<object> denseElements, JSONObject json)
		{
			foreach (object denseElement in denseElements)
			{
				AmfArray amfObj;
				AmfObject amfObj2;
				if (TryCastToArray(denseElement, out amfObj))
				{
					json.Add(AmfToJson(amfObj));
				}
				else if (TryCastToObject(denseElement, out amfObj2))
				{
					json.Add(AmfToJson(amfObj2));
				}
				else
				{
					json.Add(denseElement.ToString());
				}
			}
		}

		private static JSONObject AmfToJson(AmfObject amfObj)
		{
			JSONObject jSONObject = new JSONObject();
			AddToString(amfObj.Properties, jSONObject);
			return jSONObject;
		}

		private static void AddToString(IDictionary<string, object> associativeElements, JSONObject json)
		{
			foreach (KeyValuePair<string, object> associativeElement in associativeElements)
			{
				AmfArray amfObj;
				AmfObject amfObj2;
				if (TryCastToArray(associativeElement.Value, out amfObj))
				{
					json.AddField(associativeElement.Key, AmfToJson(amfObj));
				}
				else if (TryCastToObject(associativeElement.Value, out amfObj2))
				{
					json.AddField(associativeElement.Key, AmfToJson(amfObj2));
				}
				else if (associativeElement.Value != null)
				{
					json.AddField(associativeElement.Key, associativeElement.Value.ToString());
				}
				else
				{
					json.AddField(associativeElement.Key, "null");
				}
			}
		}

		public static string DumpAmf(object raw)
		{
			string empty = string.Empty;
			AmfObject amfObject = raw as AmfObject;
			if (amfObject != null)
			{
				empty = "{ ";
				bool flag = true;
				foreach (KeyValuePair<string, object> property in amfObject.Properties)
				{
					if (!flag)
					{
						empty += ", ";
					}
					empty += string.Format("\"{0}\" : {1}", property.Key, DumpAmf(property.Value));
					flag = false;
				}
				return empty + " }";
			}
			AmfArray amfArray = raw as AmfArray;
			if (amfArray != null)
			{
				empty = "[ ";
				bool flag2 = true;
				foreach (KeyValuePair<string, object> associativeElement in amfArray.AssociativeElements)
				{
					if (!flag2)
					{
						empty += ", ";
					}
					empty += string.Format("\"{0}\" : {1}", associativeElement.Key, DumpAmf(associativeElement.Value));
					flag2 = false;
				}
				foreach (object denseElement in amfArray.DenseElements)
				{
					empty += string.Format(", {0}", DumpAmf(denseElement));
				}
				return empty + " ]";
			}
			return raw.ToString();
		}
	}
}
