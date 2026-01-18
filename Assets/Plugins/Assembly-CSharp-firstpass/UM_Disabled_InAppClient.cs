using System;

public class UM_Disabled_InAppClient : UM_BaseInAppClient, UM_InAppClient
{
	public void Connect()
	{
	}

	public override void Purchase(UM_InAppProduct product)
	{
	}

	public override void Subscribe(UM_InAppProduct product)
	{
	}

	public override void Consume(UM_InAppProduct product)
	{
	}

	public override void FinishTransaction(UM_InAppProduct product)
	{
	}

	public void RestorePurchases()
	{
	}

	virtual void UM_InAppClient.Purchase(string productId)
	{
		Purchase(productId);
	}

	virtual void UM_InAppClient.Subscribe(string productId)
	{
		Subscribe(productId);
	}

	virtual void UM_InAppClient.Consume(string productId)
	{
		Consume(productId);
	}

	virtual void UM_InAppClient.FinishTransaction(string productId)
	{
		FinishTransaction(productId);
	}

	virtual bool UM_InAppClient.IsProductPurchased(string productId)
	{
		return IsProductPurchased(productId);
	}

	virtual bool UM_InAppClient.get_IsConnected()
	{
		return base.IsConnected;
	}

	virtual void UM_InAppClient.add_OnServiceConnected(Action<UM_BillingConnectionResult> value)
	{
		base.OnServiceConnected += value;
	}

	virtual void UM_InAppClient.remove_OnServiceConnected(Action<UM_BillingConnectionResult> value)
	{
		base.OnServiceConnected -= value;
	}

	virtual void UM_InAppClient.add_OnPurchaseFinished(Action<UM_PurchaseResult> value)
	{
		base.OnPurchaseFinished += value;
	}

	virtual void UM_InAppClient.remove_OnPurchaseFinished(Action<UM_PurchaseResult> value)
	{
		base.OnPurchaseFinished -= value;
	}

	virtual void UM_InAppClient.add_OnRestoreFinished(Action<UM_BaseResult> value)
	{
		base.OnRestoreFinished += value;
	}

	virtual void UM_InAppClient.remove_OnRestoreFinished(Action<UM_BaseResult> value)
	{
		base.OnRestoreFinished -= value;
	}
}
