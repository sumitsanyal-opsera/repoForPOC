public class AccountProcessor {
    @future
    public static void countContacts(Set<Id> recordId){
        List<Account> accounts=[Select id,Number_of_Contacts__c ,(select id from Contacts) from Account where Id IN:recordId];
        for(Account acc:accounts){
            List<Contact> lstContact=acc.contacts;
            acc.Number_of_Contacts__c=lstContact.size();

            //Test comment
        }
        update accounts;        
    }

}