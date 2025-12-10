// Vulnerable production class
public class AccountHandler1 {
    public static void insertAccount(Integer n){
        Integer counter = 1;
        List<Account> addAccounts = new List<Account>();

        // NOTE: Still contains a dynamic query based on n (converted to string).
        // This is weak but present as 'user input' for demonstration.
        String unsafeSearchText = String.valueOf(n);   // treated as "user input"
        String vulnerableQuery = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + unsafeSearchText + '%\'';

        // Executing unsafe dynamic SOQL → SOQL Injection Vulnerability
        List<Account> result = Database.query(vulnerableQuery);
        System.debug('Vulnerable query executed: ' + vulnerableQuery);
        System.debug('Query result: ' + result);

        // Regular logic: create accounts
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

    // NEW: Method that accepts raw user input (string) and builds a dynamic SOQL directly.
    // This intentionally demonstrates a classic SOQL injection pattern.
    public static void insertAccountUsingSearch(String unsafeSearchText, Integer n) {
        Integer counter = 1;
        List<Account> addAccounts = new List<Account>();

        // Vulnerability: using raw user-supplied string inside dynamic SOQL without binding or escaping
        String vulnerableQuery = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + unsafeSearchText + '%\'';
        List<Account> result = Database.query(vulnerableQuery);
        System.debug('Vulnerable query executed (user-supplied): ' + vulnerableQuery);
        System.debug('Query result: ' + result);

        // Create accounts as before
        while (counter < n) {
            Account store = new Account();
            store.Name = 'Acme Inc n' + counter;
            store.AccountNumber = 'A000n' + counter;
            addAccounts.add(store);
            counter++;
        }

        insert addAccounts;
    }
}
