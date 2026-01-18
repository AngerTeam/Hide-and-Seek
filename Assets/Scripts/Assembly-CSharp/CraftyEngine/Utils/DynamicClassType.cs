using System;
using System.Collections.Generic;
using System.Reflection;

namespace CraftyEngine.Utils
{
	public class DynamicClassType : DynamicType, IEquatable<DynamicClassType>
	{
		public int[] ignoreWarnings;

		public string namespaceName;

		public string className;

		public string fieldName;

		public DynamicClassType parentType;

		public bool hideClassDeclaration;

		public Dictionary<string, DynamicFieldType> fields;

		public Dictionary<string, DynamicMethodType> methods;

		public bool isStruct;

		public bool h;

		public string ParentTypeName
		{
			get
			{
				return (parentType != null) ? parentType.className : null;
			}
		}

		public override string Name
		{
			get
			{
				return className;
			}
		}

		public DynamicClassType(Type type)
		{
			fields = new Dictionary<string, DynamicFieldType>();
			methods = new Dictionary<string, DynamicMethodType>();
			className = type.Name;
			namespaceName = type.Namespace;
			ReadFieldsFromType(type);
		}

		public DynamicClassType(string className, string namespaceName = null, bool hideDeclaration = false)
		{
			fields = new Dictionary<string, DynamicFieldType>();
			methods = new Dictionary<string, DynamicMethodType>();
			this.className = TextUtils.ToCamelCase(className);
			this.namespaceName = namespaceName;
			hideClassDeclaration = hideDeclaration;
			fieldName = this.className;
		}

		private void ReadFieldsFromType(Type type)
		{
			FieldInfo[] array = type.GetFields();
			FieldInfo[] array2 = array;
			foreach (FieldInfo fieldInfo in array2)
			{
				if (fieldInfo.IsPublic)
				{
					DefineField(fieldInfo.Name, fieldInfo.FieldType.Name);
				}
			}
		}

		public DynamicMethodType DefinePublicMethod(string methodName, string typeName = "void", AccessibilityFlags flags = AccessibilityFlags.Public, string[] args = null)
		{
			DynamicMethodType dynamicMethodType = new DynamicMethodType(methodName);
			dynamicMethodType.returnType = typeName;
			dynamicMethodType.body = "return null;";
			dynamicMethodType.flags |= flags;
			dynamicMethodType.args = args;
			methods.Add(methodName, dynamicMethodType);
			return dynamicMethodType;
		}

		public DynamicFieldType DefineField(string fieldName, string typeName, AccessibilityFlags flags = AccessibilityFlags.Public, string defaultValue = null)
		{
			DynamicFieldType dynamicFieldType = new DynamicFieldType(fieldName, typeName);
			for (DynamicClassType dynamicClassType = this; dynamicClassType != null; dynamicClassType = dynamicClassType.parentType)
			{
				if (dynamicClassType.fields.ContainsKey(fieldName))
				{
					return dynamicClassType.fields[fieldName];
				}
			}
			dynamicFieldType.flags |= flags;
			dynamicFieldType.defaultValue = defaultValue;
			fields.Add(fieldName, dynamicFieldType);
			return dynamicFieldType;
		}

		public bool Equals(DynamicClassType other)
		{
			return className == other.className;
		}

		public void ConvertToH()
		{
			h = true;
			foreach (DynamicMethodType value in methods.Values)
			{
				value.h = true;
			}
			if (parentType != null)
			{
				parentType.ConvertToH();
			}
		}
	}
}
