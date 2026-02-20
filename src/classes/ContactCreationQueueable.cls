public class ContactCreationQueueable implements Queueable {
    private List<Account> accListToCreateContacts;
    public ContactCreationQueueable(List<Account> expectingAccountFromTrigger){
        this.accListToCreateContacts=expectingAccountFromTrigger;
    }
    public void execute(QueueableContext qCnxt){
        List<Contact> conListToInsert=new List<Contact>();
        for(Account acc:accListToCreateContacts){
            Contact con=new Contact();
            con.LastName=acc.Name;
            con.AccountId=acc.Id;
            conListToInsert.add(con);
        }
        if(conListToInsert.size()>0)
        //comments for update
        {
            Insert conListToInsert;
        }
        
    }

}