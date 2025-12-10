@isTest
private class AccountHandler1Test {
    @isTest
    static void testInsertAccountUsingSearch_NoErrors() {
        // Sample "user" input (treated as unsafe in the production method)
        String userInput = 'anything';

        Test.startTest();
            // Call the vulnerable method which also inserts accounts
            AccountHandler1.insertAccountUsingSearch(userInput, 3);
        Test.stopTest();

        // Verify accounts were created by the method
        List<Account> inserted = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE 'Acme Inc n%'
        ];

        // Clear, descriptive assertion messages to satisfy quality gates
        System.assert(inserted.size() > 0, 'Expected at least one account to be created by insertAccountUsingSearch.');
        System.assertEquals(
            2,
            inserted.size(),
            'Expected exactly 2 accounts when n = 3 (counter starts at 1 and loops while counter < n).'
        );
    }
}
