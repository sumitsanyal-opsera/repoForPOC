public class AddPrimaryContact implements Queueable {
    private Contact contacts;
    private String state;
    
    public AddPrimaryContact (Contact c,String s){
        this.contacts=c;
        this.state=s;
    }
    public void execute(QueueableContext context){
        List<Account> listAccount=[Select id,name,(select id,firstname,lastname from Contacts) from Account where BillingState=:state LIMIT 200];
        List<Contact> lstContact=new List<Contact>();
        for(Account acc:listAccount){
            Contact con=contacts.clone(false,false,false,false);
            con.AccountId=contacts.Id;
            lstContact.add(con);
        }

//Test comment for the AddPrimaryContact class


        if(lstContact.size()>0){
            update lstContact;
        }
        
    }
}
