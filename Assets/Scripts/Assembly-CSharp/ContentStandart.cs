using System;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

public class ContentStandart
{
	public static string key = "NHAemVlU";

	public static WWWForm GetForm(string cmd = null, string newKey = null)
	{
		WWWForm wWWForm = new WWWForm();
		string timeStamp = GetTimeStamp();
		string fieldName = "sig";
		wWWForm.AddField(fieldName, Md5Sum(cmd + timeStamp + ((!string.IsNullOrEmpty(newKey)) ? newKey : key)));
		wWWForm.AddField("ts", timeStamp);
		if (!string.IsNullOrEmpty(cmd))
		{
			wWWForm.AddField("cmd", cmd);
		}
		return wWWForm;
	}

	public static int GetUnixTimeStamp()
	{
		return (int)DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1)).TotalSeconds;
	}

	public static string GetTimeStamp()
	{
		return DateTime.Now.ToString("yyyyMMddHHmmssffff");
	}

	public static string Md5Sum(string strToEncrypt)
	{
		UTF8Encoding uTF8Encoding = new UTF8Encoding();
		byte[] bytes = uTF8Encoding.GetBytes(strToEncrypt);
		MD5CryptoServiceProvider mD5CryptoServiceProvider = new MD5CryptoServiceProvider();
		byte[] array = mD5CryptoServiceProvider.ComputeHash(bytes);
		string text = string.Empty;
		for (int i = 0; i < array.Length; i++)
		{
			text += Convert.ToString(array[i], 16).PadLeft(2, '0');
		}
		return text.PadLeft(32, '0');
	}
}
