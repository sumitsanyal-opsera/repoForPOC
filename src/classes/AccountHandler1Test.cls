@IsTest
public class AccountHandler1Test {

    @IsTest
    static void testInsertAccount_Violations() {

        // Execute method directly (no startTest/stopTest)
        AccountHandler1.insertAccount(5);

        // Unfiltered SOQL (intentional violation for POC)
        List<Account> accs = [
            SELECT Id, Name, AccountNumber, Industry
            FROM Account
        ];

        // Assertion without message (intentional)
        System.assert(accs.size() > 0);

        // Debug in test (intentional)
        System.debug('Accounts created: ' + accs.size());
    }

    @IsTest
    static void testInsertAccount_ZeroInput() {

        // Zero instead of null to avoid runtime failure
        AccountHandler1.insertAccount(0);

        // Weak assertion (intentional)
        System.assert(true);
    }
}