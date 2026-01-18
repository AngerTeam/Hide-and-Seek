using System;

[Flags]
public enum UnityLayerFlags
{
	Default = 1,
	TransparentFX = 2,
	Ignore_Raycast = 4,
	Water = 0x10,
	UI = 0x20,
	VoxelEnviroment = 0x100,
	HandEnviroment = 0x200,
	PlayerRigidBody = 0x400,
	PassableObject = 0x800,
	ImpassableObject = 0x1000,
	Enemy = 0x4000,
	Friend = 0x8000,
	UIFX = 0x10000,
	KillCam = 0x20000,
	Background = 0x40000
}
