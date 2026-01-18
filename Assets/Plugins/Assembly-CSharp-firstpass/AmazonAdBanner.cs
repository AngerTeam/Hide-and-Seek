using System;

public class AmazonAdBanner
{
	public enum BannerAligns
	{
		Top = 0,
		TopLeft = 1,
		TopRight = 2,
		Bottom = 3,
		BottomLeft = 4,
		BottomRight = 5
	}

	private int _id;

	private BannerAligns _position;

	private AMN_AdProperties _properties;

	private bool _isLoaded;

	private bool _isOnScreen;

	private int _width;

	private int _height;

	public int Id
	{
		get
		{
			return _id;
		}
	}

	public bool IsLoaded
	{
		get
		{
			return _isLoaded;
		}
	}

	public bool IsOnScreen
	{
		get
		{
			return _isOnScreen;
		}
	}

	public int Width
	{
		get
		{
			return _width;
		}
	}

	public int Height
	{
		get
		{
			return _height;
		}
	}

	public AMN_AdProperties Properties
	{
		get
		{
			return _properties;
		}
	}

	public event Action<AmazonAdBanner> OnLoadedAction = delegate
	{
	};

	public event Action<AmazonAdBanner> OnFailedLoadingAction = delegate
	{
	};

	public event Action<AmazonAdBanner> OnExpandedAction = delegate
	{
	};

	public event Action<AmazonAdBanner> OnDismissedAction = delegate
	{
	};

	public event Action<AmazonAdBanner> OnCollapsedAction = delegate
	{
	};

	public AmazonAdBanner(BannerAligns position, int id)
	{
		_id = id;
		_position = position;
		AMN_AdvertisingProxy.CreateBanner(GetPosition(_position), _id);
	}

	public void SetProperties(int width, int height, AMN_AdProperties props)
	{
		_width = width;
		_height = height;
		_properties = props;
	}

	public void Hide(bool hide)
	{
		AMN_AdvertisingProxy.HideBanner(hide, _id);
	}

	public void Destroy()
	{
		AMN_AdvertisingProxy.DestroyBanner(_id);
	}

	public void Refresh()
	{
		AMN_AdvertisingProxy.RefreshBanner(_id);
	}

	public void HandleOnBannerAdLoaded()
	{
		_isLoaded = true;
		this.OnLoadedAction(this);
	}

	public void HandleOnBannerAdFailedToLoad()
	{
		this.OnFailedLoadingAction(this);
	}

	public void HandleOnBannerAdExpanded()
	{
		_isOnScreen = true;
		this.OnExpandedAction(this);
	}

	public void HandleOnBannerAdDismissed()
	{
		_isOnScreen = false;
		this.OnDismissedAction(this);
	}

	public void HandleOnBannerAdCollapsed()
	{
		_isOnScreen = false;
		this.OnCollapsedAction(this);
	}

	private string GetPosition(BannerAligns BannerAlign)
	{
		string result = "BM";
		switch (BannerAlign)
		{
		case BannerAligns.Top:
			result = "TM";
			break;
		case BannerAligns.TopLeft:
			result = "TL";
			break;
		case BannerAligns.TopRight:
			result = "TR";
			break;
		case BannerAligns.Bottom:
			result = "BM";
			break;
		case BannerAligns.BottomLeft:
			result = "BL";
			break;
		case BannerAligns.BottomRight:
			result = "BR";
			break;
		}
		return result;
	}
}
