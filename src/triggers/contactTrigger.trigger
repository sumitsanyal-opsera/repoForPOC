trigger contactTrigger on Contact (after insert,after update, after delete) {
    
    list<Account> listaccount=new list<Account>();
    
    
    set<Id> setid=new set<Id>();   //store account ids
    
    Map<Id,Contact> MapAcc=new Map<Id,Contact>(); //store related account id and Contact
    
    if(trigger.isInsert || trigger.isUpdate && trigger.isAfter)
    {
        for(contact c : trigger.new)
        {
            setid.add(c.AccountId); //storing ids of all related accounts
        }    
        for(Contact c:trigger.new)
        {
            MapAcc.put(c.AccountId,c);
        }      
        
        for(Account acc : [select Id,Name,isTeam__c,(Select LastName from contacts) from Account where Id IN :setid ])
        {
            //acc.Total_Contact__c=acc.contacts.size();
            if(acc.contacts.size() > 1)
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
        
        if(listaccount.size()>0)
        {
            update listaccount; 
        }
        
    }  
    else if(trigger.isDelete && trigger.isAfter)
    {
        for(contact c : trigger.old)
        {
            setid.add(c.AccountId); //storing ids of all related accounts
        }    
        for(Contact c:trigger.old)
        {
            MapAcc.put(c.AccountId,c);
        }      
        
        for(Account acc : [select Id,Name,Total_Contact__c,isTeam__c,(Select LastName from contacts) from Account where Id IN :setid ])
        {
            //acc.Total_Contact__c=acc.contacts.size();
            if(acc.contacts.size() > 1)
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
        if(listaccount.size()>0)  //null pointer check
        {
            update listaccount;
        }
               
    }
}