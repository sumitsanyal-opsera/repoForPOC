public class AccountHandler1 {

    //  Violation: Method is static and doing DML + SOQL (poor separation of concerns)
    //  Violation: No input validation
    //  Violation: No exception handling
    public static void insertAccount(Integer n) {

        Integer counter = 0; //  Violation: Magic number usage
        List<Account> addAccounts = new List<Account>();

        //  Violation: User-controlled input directly concatenated into dynamic SOQL
        String unsafeSearchText = String.valueOf(n);
        String vulnerableQuery =
            'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + unsafeSearchText + '%\'';

        //  Violation: Dynamic SOQL without bind variables (SOQL Injection risk)
        List<Account> result = Database.query(vulnerableQuery);

        //  Violation: Excessive debug logs (log flooding)
        System.debug('Executing Query: ' + vulnerableQuery);
        System.debug('Query Result: ' + result);

        //  Violation: Loop boundary depends on unvalidated input
        while (counter < n) {

            //  Violation: Debug inside loop
            System.debug('Counter value: ' + counter);

            Account acc = new Account();

            //  Violation: Hardcoded strings instead of constants/custom labels
            acc.Name = 'Acme Inc ' + counter;
            acc.AccountNumber = 'ACC-' + counter;

            addAccounts.add(acc);

            counter++; //  Violation: Increment logic hidden inside loop body
        }

        //  Violation: DML without checking list size
        //  Violation: No partial success handling (Database.insert with allOrNone=false not used)
        insert addAccounts;
    }
}