public class contactTriggerHelper {
    
    public  void contactUpdate()
    { 
        LIST<Account> listaccount=new LIST<Account>();
        set<Id> setid=new set<Id>(); 
        List<Account> acct=[select Id,Name,Total_Contact__c,isTeam__c,(Select LastName from contacts) from Account where Id IN :setid ];
        for(Account acc : acct)
        {
            acc.Total_Contact__c=acc.contacts.size();
            if(acc.Total_Contact__c > 1)
            {
                acc.isTeam__c=True;
                listaccount.add(acc);
            }
            else
            {
                acc.isTeam__c=False;
                listaccount.add(acc);
            }
            
        }
       update acct; 
        
    }
}