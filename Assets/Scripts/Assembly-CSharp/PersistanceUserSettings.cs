using System;

[Serializable]
public class PersistanceUserSettings
{
	public int lastNewsViewTime;

	public float fieldOfView = 75f;

	public float smoothRotation = 5f;

	public float sensitivityMultiplier = 1f;

	public float maxSmoothAngleDiff = 15f;

	public bool autoAiming;

	public bool autoShoot;

	public bool autoAlignTpsCamera;

	public bool showEnemyNickname;

	public bool musicOn = true;

	public bool soundOn = true;

	public float soundVolume = 1f;

	public float musicVolume = 1f;

	public bool defaultSoundValuesVetsion1Set;

	public string lang = string.Empty;

	public bool defaultInputValuesVetsion1Set;

	public bool isSmoothLookEnabled;

	public float touchSensitivity = 50f;
}
