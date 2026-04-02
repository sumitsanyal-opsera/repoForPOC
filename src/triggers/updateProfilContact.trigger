trigger updateProfilContact on Account (after insert,after update) {
    list<Contact> lstcontact=new list<contact>([select id, firstname,lastname,accountid from contact where accountid IN: trigger.new]);
    map<id,account> mapaccount=new map<id,account>([select id,website from account where id IN:trigger.new]);
    list<Contact> updateContact=new list<Contact>();
    
    if(trigger.isInsert|| trigger.isUpdate && trigger.isAfter)
    {
        for(Contact obj:lstcontact)
        {
            Account acc=mapaccount.get(obj.accountid);
            if(obj.FirstName!=Null)
            {
                String firstname1=obj.firstname.substring(0,1);
                obj.Profile__c=acc.Website+'/'+firstname1+obj.LastName;
                updateContact.add(obj);
            }
        }
    }
    if(updateContact.size()>0)
    {
        upsert  updateContact;
    }
    
}