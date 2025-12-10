@isTest
private class AccountHandler1Test {
    static testMethod void testInsertAccountUsingSearch_Vulnerable_and_AssertsWithoutMessage() {
        String userInput = 'anything';

        Test.startTest();      // <-- Correct
        AccountHandler1.insertAccountUsingSearch(userInput, 3);
        Test.stopTest();       // <-- Correct

        List<Account> inserted = [
            SELECT Id, Name FROM Account WHERE Name LIKE 'Acme Inc n%'
        ];

        // Assertions without messages – intentionally vulnerable
        System.assert(inserted.size() > 0);
        System.assertEquals(2, inserted.size());
    }
}
