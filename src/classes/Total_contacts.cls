public class Total_contacts {
   
    public static void total()
    {
        List<Account> accList=[Select id,Total_Contact__c,(Select LastName from Contacts) from Account];
        for(Account acc: accList)
        {
            Account ac1=new Account();
            ac1.Id=acc.id;
            ac1.Total_Contact__c=acc.contacts.size();
        }
    }
}