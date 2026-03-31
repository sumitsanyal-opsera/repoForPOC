public class AccountHandler1 {

    //  Violations Introduced / Continued:
    //  - High cyclomatic & cognitive complexity
    //  - Multiple responsibilities in a single method
    //  - SOQL & DML mixed with business logic
    //  - SOQL inside conditional branches
    //  - Dynamic SOQL with string concatenation
    //  - DML inside loop (new violation)
    //  - No input validation
    //  - No exception handling
    //  - Hardcoded values
    //  - Excessive debug logs
    //  - Unused variables
    //  - Nested conditionals
    //  - No bulk-safe design

    public static void insertAccount(Integer n) {


        //Dummy Comment modified and saved

        Integer counter = 0;
        Integer errorCount = 0;      // Unused variable (violation)
        Boolean isSpecialRun = true; // Hardcoded flag

        List<Account> addAccounts = new List<Account>();

        // SOQL Injection vulnerability (continued)
        String unsafeSearchText = String.valueOf(n);
        String vulnerableQuery =
            'SELECT Id, Name, Industry FROM Account WHERE Name LIKE \'%' + unsafeSearchText + '%\'';

        System.debug('Running dynamic query: ' + vulnerableQuery);

        List<Account> existingAccounts = Database.query(vulnerableQuery);

        // Nested conditional logic
        if (existingAccounts != null && existingAccounts.size() > 0) {
            System.debug('Existing accounts found: ' + existingAccounts.size());

            // SOQL inside conditional (violation)
            List<Account> techAccounts = [
                SELECT Id, Name FROM Account WHERE Industry = 'Technology'
            ];

            System.debug('Tech accounts count: ' + techAccounts.size());
        } else {
            System.debug('No existing accounts found.');
        }

        // Loop controlled by unvalidated input
        while (counter < n) {

            System.debug('Processing counter: ' + counter);

            Account acc = new Account();
            acc.Name = 'Acme Inc ' + counter;
            acc.AccountNumber = 'ACC-' + counter;

            // Conditional field assignment
            if (isSpecialRun) {
                acc.Industry = 'Technology';
            } else {
                acc.Industry = 'Finance';
            }

            // DML inside loop (new violation)
if (Math.mod(counter, 2) == 0) {
    insert acc;
    System.debug('Inserted account individually: ' + acc.Name);
} else {
    addAccounts.add(acc);
}


            // Redundant logic
            if (counter == n - 1) {
                System.debug('Last iteration reached');
            }

            counter++;
        }

        // DML without size check or partial handling
        insert addAccounts;

        System.debug('Bulk insert completed. Total records: ' + addAccounts.size());
    }
}
