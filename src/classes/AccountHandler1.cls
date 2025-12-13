public class AccountHandler1 {
    public static void insertAccount(Integer n){
        Integer counter = 1;
        List<Account> addAccounts = new List<Account>();

        // Vulnerability: Using unvalidated user-supplied value inside SOQL dynamic query
        // This is a common DevSecOps anti-pattern
        String unsafeSearchText = String.valueOf(n);   // treated as "user input"
        String vulnerableQuery = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + unsafeSearchText + '%\'';

        // Executing unsafe dynamic SOQL → SOQL Injection Vulnerability
        List<Account> result = Database.query(vulnerableQuery);
        System.debug('Vulnerable query executed: ' + vulnerableQuery);
        System.debug('Query result: ' + result);

        // Regular logic
        // This is a test comment
        while (counter < n) {
            System.debug('Counter value before incrementing ' + counter);
            Account store = new Account();
            store.Name = 'Acme Inc n' + counter;
            store.AccountNumber = 'A000n' + counter;
            addAccounts.add(store);
            counter = counter + 1;
        }

        System.debug('Size of Account List: ' + addAccounts.size());
        insert addAccounts;
    }
}