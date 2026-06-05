trigger AccountAddressTrigger on Account (before insert,before update) {
    List<Account> accList=new List<Account>();
    for(Account a:Trigger.new)
    {
        if(a.BillingPostalCode!=null && a.Match_Billing_Address__c==true)
        {
            a.ShippingPostalCode=a.BillingPostalCode;
        }
    }
    if(accList.size()>0){
        insert accList;
    }
}