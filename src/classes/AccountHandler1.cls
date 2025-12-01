public class AccountHandler1 {
    public static void insertAccount(Integer n){
        Integer counter=1;
        List<Account> addAccounts=new List<Account>();
        while(counter<n){
            System.debug('Counter value before incrementing ' + counter);
            Account store=new Account();
            store.Name='Acme Inc n'+ counter;

            
            store.AccountNumber='A000n'+counter;
            addAccounts.add(store);
            System.debug(addAccounts);
            counter=counter+1;
            System.debug('Counter value after incrementing'+counter);
            //Dummy class
        }
        System.debug('Size of Account List: ' + addAccounts.size() );
        System.debug('Elements in Account List: ' + addAccounts);
        insert addAccounts;
        
    }

}