@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void Setup(){
        List<Account> accounts=new List<Account>();
        for(Integer i=0;i<50;i++){
            accounts.add(new Account(name='Test Account'+i,BillingState='CA'));
        }
        for(Integer j=0;j<50;j++){
            accounts.add(new Account(name='Test Acc'+j,BillingState='NY'));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable(){
        Contact c=new Contact(FirstName='Test',LastName='Contact');
        insert c;
        String s='CA';
        AddPrimaryContact apc=new AddPrimaryContact(c,s);
        System.test.startTest();
        System.enqueueJob(apc);
        System.test.stopTest();
        System.assertEquals(50, [SELECT count() FROM Contact WHERE accountId IN (Select id from Account WHERE BillingState =:s)]);
    }
    
}