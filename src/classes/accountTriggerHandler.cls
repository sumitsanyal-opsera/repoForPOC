public class accountTriggerHandler {
    public static void updateLegalHoldOnContact(Map<id,Account> newRecordsMap){
        
        System.debug('#Started');
        List<account> accountwithContacts = new List<account>();
        List<Contact> ContactsinCOnsideration = new List<Contact>();
        accountwithContacts = [select id, Legal_Hold__c , (select id, Legal_Hold__c  from Contacts) from account where id in :newRecordsMap.KeySet()];
        System.debug('#accountwithContacts'+accountwithContacts);
        if(accountwithContacts!=null && accountwithContacts.size()>0){
            for(Account acc: accountwithContacts){
                for(Contact contactRec : acc.Contacts){
                    System.debug('#contactRec'+contactRec);
                    if(acc.Legal_Hold__c != null){
                        contactRec.Legal_Hold__c = acc.Legal_Hold__c;   
                        ContactsinCOnsideration.add(contactRec);
                    }
                }
            }
            if(ContactsinCOnsideration!=null && ContactsinCOnsideration.size()>0){
                System.debug('#updating');
                update ContactsinCOnsideration;
            }
        }     
        
        //Test comment added in the Apex class
        
        System.debug('#END');
    }    
}