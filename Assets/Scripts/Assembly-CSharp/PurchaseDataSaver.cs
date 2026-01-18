using System.Collections.Generic;
using CraftyEngine.Utils;

public class PurchaseDataSaver : PermanentSingleton
{
	private PurchasesSaveData purchasesSaveData_;

	private string saveFileName = "MGCPurchases";

	private string encryptedKey_;

	public List<PurchaseSaveData> Purchases { get; private set; }

	public override void Init()
	{
		encryptedKey_ = "SomeStubKey";
		Load();
	}

	public void AddPurchase(PurchaseSaveData purchase)
	{
		Purchases.Add(purchase);
		Save();
	}

	public void RemovePurchase(string orderId)
	{
		foreach (PurchaseSaveData purchase in Purchases)
		{
			if (purchase.orderId == orderId)
			{
				Purchases.Remove(purchase);
				Save();
				break;
			}
		}
	}

	public void Save()
	{
		purchasesSaveData_ = new PurchasesSaveData();
		purchasesSaveData_.purchases = Purchases.ToArray();
		DataSaver.Save(purchasesSaveData_, saveFileName, encryptedKey_);
	}

	private void Load()
	{
		Purchases = new List<PurchaseSaveData>();
		purchasesSaveData_ = DataSaver.Load<PurchasesSaveData>(saveFileName, encryptedKey_);
		if (purchasesSaveData_ == null)
		{
			purchasesSaveData_ = new PurchasesSaveData();
			return;
		}
		PurchaseSaveData[] purchases = purchasesSaveData_.purchases;
		foreach (PurchaseSaveData item in purchases)
		{
			Purchases.Add(item);
		}
	}
}
