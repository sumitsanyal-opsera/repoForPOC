// Test class that intentionally contains assertions WITHOUT messages
@isTest
private class AccountHandler1Test {
    static testMethod void testInsertAccountUsingSearch_Vulnerable_and_AssertsWithoutMessage() {
        // Provide a sample "user" search string (could be malicious in real scenarios)
        String userInput = 'anything';

        Test.startTest();
        // Call the vulnerable method that concatenates the user input into dynamic SOQL
        AccountHandler1.insertAccountUsingSearch(userInput, 3);
        Test.stopTest();

        // Query the accounts that were inserted by the method
        List<Account> inserted = [SELECT Id, Name FROM Account WHERE Name LIKE 'Acme Inc n%'];

        // Vulnerability for quality gate: assertions WITHOUT an assertion message.
        // ApexAssertionsShouldIncludeMessage will flag these.
        System.assert(inserted.size() > 0);            // <-- missing message
        System.assertEquals(2, inserted.size());       // <-- missing message
    }
}
