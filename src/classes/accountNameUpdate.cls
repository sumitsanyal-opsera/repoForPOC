public class accountNameUpdate 
{
    @InvocableMethod
    public static void testProcess(List<account> accounts)
    {
        List<Account> acct=new List<account>();
        for(Account acc:accounts)
        {
            Account temp=new account();
            temp.name='-wk'+acc.name;
            temp.id=acc.id;
            acct.add(temp);
        }
        if(acct!=Null)
        {
            update acct;
        }           
        
    }

}