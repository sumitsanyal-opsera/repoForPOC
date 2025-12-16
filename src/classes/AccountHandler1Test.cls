@IsTest
public class AccountHandler1Test {

    @IsTest
    static void testInsertAccount_Violations() {

        //  FIX: Fully qualified Test framework

        //  Violation: Magic number
        AccountHandler1.insertAccount(5);

        System.Test.stopTest();

        //  Violation: Unfiltered SOQL in test
        List<Account> accs = [
            SELECT Id, Name
            FROM Account
        ];

        //  Violation: Assertion without message
        System.assert(accs.size() > 0);

        //  Violation: Debug in test class
        System.debug('Accounts created: ' + accs.size());
    }

    @IsTest
    static void testInsertAccount_NullInput() {

        System.Test.startTest();

        //  Violation: Null passed, no exception asserted
        AccountHandler1.insertAccount(null);

        System.Test.stopTest();

        //  Violation: No assertions
    }
}
