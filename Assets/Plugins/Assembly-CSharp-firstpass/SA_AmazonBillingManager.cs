using System;
using System.Collections.Generic;
using UnityEngine;

public class SA_AmazonBillingManager : AMN_Singleton<SA_AmazonBillingManager>
{
	public enum status
	{
		SUCCESSFUL = 0,
		FAILED = 1
	}

	public string currentSKU = string.Empty;

	private bool _isInitialized;

	public Dictionary<string, AmazonProductTemplate> availableItems;

	public List<string> unavailableSkus;

	public List<SA_AmazonReceipt> listReceipts;

	public bool IsInitialized
	{
		get
		{
			return _isInitialized;
		}
	}

	public event Action<AMN_GetUserDataResponse> OnGetUserDataReceived = delegate
	{
	};

	public event Action<AMN_PurchaseResponse> OnPurchaseProductReceived = delegate
	{
	};

	public event Action<AMN_GetProductDataResponse> OnGetProductDataReceived = delegate
	{
	};

	public event Action<AMN_GetPurchaseProductsUpdateResponse> OnGetPurchaseProductsUpdatesReceived = delegate
	{
	};

	private void Awake()
	{
	}

	public void Initialize()
	{
		Initialize(AmazonNativeSettings.Instance.InAppProducts);
	}

	public void Initialize(List<AmazonProductTemplate> product_ids)
	{
		if (!_isInitialized)
		{
			Init(product_ids);
		}
	}

	public void AddProduct(string sku)
	{
		AmazonProductTemplate amazonProductTemplate = new AmazonProductTemplate();
		amazonProductTemplate.Sku = sku;
		AmazonProductTemplate amazonProductTemplate2 = amazonProductTemplate;
		int num = IsExistsInSettings(amazonProductTemplate2);
		if (num != -1)
		{
			AmazonNativeSettings.Instance.InAppProducts.RemoveAt(num);
		}
		AmazonNativeSettings.Instance.InAppProducts.Add(amazonProductTemplate2);
		Debug.Log("AddProduct(string sku)" + sku);
	}

	public void GetUserData()
	{
	}

	public void Purchase(string SKU)
	{
	}

	public void GetProductUpdates()
	{
	}

	private void Init(List<AmazonProductTemplate> product_ids)
	{
	}

	private void SubscribeToEvents()
	{
	}

	private int IsExistsInSettings(AmazonProductTemplate product)
	{
		foreach (AmazonProductTemplate inAppProduct in AmazonNativeSettings.Instance.InAppProducts)
		{
			if (inAppProduct.Sku.Equals(product.Sku))
			{
				return AmazonNativeSettings.Instance.InAppProducts.IndexOf(inAppProduct);
			}
		}
		return -1;
	}
}
