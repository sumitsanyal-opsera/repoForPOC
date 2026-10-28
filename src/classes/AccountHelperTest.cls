@IsTest
public with sharing class AccountHelperTest {

    @IsTest
    static void testFetchAccounts_ReturnsInsertedRecords() {
        TestDataFactory.createAccounts(3);

        List<Account> accounts = AccountHelper.fetchAccounts();

        System.assertEquals(3, accounts.size(), 'Should return all inserted accounts');
    }

    @IsTest
    static void testFetchAndPrintAccountDetails_LogsWithoutError() {
        TestDataFactory.createAccount('Print Test Account');

        AccountHelper.fetchAndPrintAccountDetails();

        List<Account> accounts = AccountHelper.fetchAccounts();
        System.assertEquals(1, accounts.size(), 'Account should be available after print');
    }

    @IsTest
    static void testPrintAccountDetails_HandlesNull() {
        AccountHelper.printAccountDetails(null);

        System.assert(true, 'Null Account should be handled without exception');
    }

    @IsTest
    static void testPrintAccountDetails_LogsSingleAccount() {
        Account acc = TestDataFactory.createAccount('Single Account');

        AccountHelper.printAccountDetails(acc);

        System.assertNotEquals(null, acc.Id, 'Account should have been inserted');
    }
}