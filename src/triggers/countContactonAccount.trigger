trigger countContactonAccount on Contact (after insert,after update,after delete) {
    List<Account> accList=[Select id,name,(select id,name from contacts) from account];
    for(Account acc:accList){
        acc.Count_Contact__c=acc.Contacts.size();
    }
    update accList;

}