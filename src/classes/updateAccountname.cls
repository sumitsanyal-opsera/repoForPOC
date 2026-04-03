public class updateAccountname {
    
    public void updateAccount(List<Id> accID)
    {       
        Account acc=new Account();
        acc.name = '-wk'+''+acc.name;
        
        insert acc;  
        
    }
    
}