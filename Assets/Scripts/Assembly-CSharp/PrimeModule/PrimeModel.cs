using UnityEngine;

namespace PrimeModule
{
	public class PrimeModel : Singleton
	{
		public bool newMapsFormat;

		public int mapId;

		public string mapFile;

		public int modeId;

		public int ambientSoundId;

		public int useClouds;

		public int skyboxId;

		public string rulesJson;

		public ServerMapSettings rules;

		public bool comeback;

		public Vector3? cameraPosition;

		public Vector3? cameraRotation;

		public bool hideAndSeek = true;

		public float forceRespawnTime = 30f;

		public ServerMapSettings GetRules()
		{
			if (rules == null)
			{
				if (string.IsNullOrEmpty(rulesJson))
				{
					Log.Error("Unable to find rules for prime state!");
					return null;
				}
				rules = JsonUtility.FromJson<ServerMapSettings>(rulesJson);
			}
			return rules;
		}
	}
}
