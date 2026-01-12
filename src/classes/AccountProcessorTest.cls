
public class AccountProcessorTest {
    static testMethod TestAccountProcessorTest(){
        Account a=new Account();
        a.Name='Test Account';
        insert a;
        
        Contact c=new Contact();
        c.FirstName='Test';
        c.LastName='COntact';
        c.AccountId=a.Id;
        
        Set<Id> setAccId=new Set<Id>();
        setAccId.add(a.Id);
        
        AccountProcessor.countContacts(setAccId);
        
               

        //Dummy test class comment
        
        Account acc=[select Number_of_Contacts__c from account where id=:a.id Limit 1];
        System.assertEquals(Integer.valueOf(acc.Number_of_Contacts__c),1);
     }
 
}
