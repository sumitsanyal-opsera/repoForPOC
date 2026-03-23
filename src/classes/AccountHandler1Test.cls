@IsTest
public class AccountHandler1Test {

    @IsTest
    static void testInsertAccount_WithValidInput() {

        System.Test.startTest();
        AccountHandler1.insertAccount(5);
        System.Test.stopTest();

        List<Account> accs = [
            SELECT Id, Name
            FROM Account
        ];

        //  System.debug vulnerability (intentional)

        // Test comments by Sumit
        
        
        System.debug('Number of accounts created: ' + accs.size());

        // Adding Test comment in the class
        //Test comment for checking script
        System.assert(
            accs.size() > 0,
            'Accounts should be created when a positive number is passed'
        );
    }

    @IsTest
    static void testInsertAccount_WithZeroInput() {

        System.Test.startTest();
        AccountHandler1.insertAccount(0);
        System.Test.stopTest();

        List<Account> accs = [
            SELECT Id
            FROM Account
        ];

        //  System.debug vulnerability (intentional)
        System.debug('Accounts found for zero input: ' + accs.size());

        // Test comments by Sumit
        
        System.assertEquals(
            0,
            accs.size(),
            'No accounts should be created when input is zero'
        );
    }
}
