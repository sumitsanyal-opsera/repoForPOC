trigger AccountToContactUpdate on Account (after insert /*,after update*/) {
    
    
    
    for(Account acc:trigger.new){
        Contact con=new Contact();
            con.LastName='Test Contact-'+acc.Name;
            con.AccountId=acc.Id;
            insert con;
        }
    }
    
    /*Set<Id> getAccountId=new Set<Id>();
    for(Account acc:trigger.new){
        getAccountId.add(acc.Id);
    }
    
    List<Contact> contactList=[Select id,accountId from Contact where accountId in:getAccountId];
    List<Contact> lstContact=new List<Contact>();
    for(Account acc:trigger.new){
        for(Contact con:contactList){
            //con.MailingStreet=acc.BillingStreet;
            con.Phone=acc.Phone;
            lstContact.add(con);
        }
    }
    if(lstContact.size()>0){
        update lstContact;
    }
*/