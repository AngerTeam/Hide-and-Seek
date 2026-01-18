using System;
using SA.Common.Models;
using SA.Common.Pattern;
using UnityEngine;

public class UM_Camera : Singleton<UM_Camera>
{
	public event Action<UM_ImagePickResult> OnImagePicked = delegate
	{
	};

	public event Action<UM_ImageSaveResult> OnImageSaved = delegate
	{
	};

	public event Action<UM_ImagesPickResult> OnImagesPicked = delegate
	{
	};

	private void Awake()
	{
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		Singleton<AndroidCamera>.Instance.OnImagePicked += OnAndroidImagePicked;
		IOSCamera.OnImagePicked += OnIOSImagePicked;
		Singleton<AndroidCamera>.Instance.OnImageSaved += OnAndroidImageSaved;
		IOSCamera.OnImageSaved += OnIOSImageSaved;
		Singleton<AndroidCamera>.Instance.OnImagesPicked += HandleOnImagesPicked;
	}

	public void SaveImageToGalalry(Texture2D image)
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidCamera>.Instance.SaveImageToGallery(image);
			break;
		case RuntimePlatform.IPhonePlayer:
			Singleton<IOSCamera>.Instance.SaveTextureToCameraRoll(image);
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	public void SaveScreenshotToGallery()
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidCamera>.Instance.SaveScreenshotToGallery();
			break;
		case RuntimePlatform.IPhonePlayer:
			Singleton<IOSCamera>.Instance.SaveScreenshotToCameraRoll();
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	public void GetImageFromGallery()
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidCamera>.Instance.GetImageFromGallery();
			break;
		case RuntimePlatform.IPhonePlayer:
			Singleton<IOSCamera>.Instance.PickImage(ISN_ImageSource.Library);
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	public void GetImagesFromGallery()
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidCamera>.Instance.GetImagesFromGallery();
			break;
		case RuntimePlatform.IPhonePlayer:
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	public void GetImageFromCamera()
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidCamera>.Instance.GetImageFromCamera();
			break;
		case RuntimePlatform.IPhonePlayer:
			Singleton<IOSCamera>.Instance.PickImage(ISN_ImageSource.Camera);
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	private void HandleOnImagesPicked(AndroidImagesPickResult result)
	{
		this.OnImagesPicked(new UM_ImagesPickResult(result.IsSucceeded, result.Images));
	}

	private void OnAndroidImagePicked(AndroidImagePickResult obj)
	{
		UM_ImagePickResult obj2 = new UM_ImagePickResult(obj.Image);
		this.OnImagePicked(obj2);
	}

	private void OnIOSImagePicked(IOSImagePickResult obj)
	{
		UM_ImagePickResult obj2 = new UM_ImagePickResult(obj.Image);
		this.OnImagePicked(obj2);
	}

	private void OnAndroidImageSaved(GallerySaveResult res)
	{
		UM_ImageSaveResult obj = new UM_ImageSaveResult(res.imagePath, res.IsSucceeded);
		this.OnImageSaved(obj);
	}

	private void OnIOSImageSaved(Result res)
	{
		UM_ImageSaveResult obj = new UM_ImageSaveResult(string.Empty, res.IsSucceeded);
		this.OnImageSaved(obj);
	}
}
