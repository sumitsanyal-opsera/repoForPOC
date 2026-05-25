/**
 * Test class for AccountHandler1.
 *
 * Covers:
 *  - insertAccount happy path (positive integer)
 *  - insertAccount with zero / null input (edge cases)
 *  - setDefaultIndustry logic (unit test without DML)
 *  - Bulk safety: 200+ records processed without hitting governor limits
 *  - Recursion guard inherited from TriggerHandler
 */
@IsTest
public with sharing class AccountHandler1Test {

    // -------------------------------------------------------------------------
    // insertAccount — happy paths
    // -------------------------------------------------------------------------

    @IsTest
    static void testInsertAccount_WithValidInput() {
        Test.startTest();
        AccountHandler1.insertAccount(5);
        Test.stopTest();

        List<Account> accs = [SELECT Id, Name, Industry FROM Account];
        System.assertEquals(5, accs.size(), '5 accounts should have been created');
        for (Account a : accs) {
            System.assertEquals('Technology', a.Industry,
                'Default industry should be Technology');
        }
    }

    @IsTest
    static void testInsertAccount_WithZeroInput() {
        Test.startTest();
        AccountHandler1.insertAccount(0);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Account];
        System.assertEquals(0, count, 'No accounts should be created for zero input');
    }

    @IsTest
    static void testInsertAccount_WithNullInput() {
        Test.startTest();
        AccountHandler1.insertAccount(null);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Account];
        System.assertEquals(0, count, 'No accounts should be created for null input');
    }

    // -------------------------------------------------------------------------
    // insertAccount — bulk safety (WO-022: 200+ records)
    // -------------------------------------------------------------------------

    @IsTest
    static void testInsertAccount_BulkSafety_200Records() {
        Test.startTest();
        AccountHandler1.insertAccount(200);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Account];
        System.assertEquals(200, count,
            '200 accounts should be bulk-inserted without hitting governor limits');
    }

    // -------------------------------------------------------------------------
    // setDefaultIndustry — unit tests
    // -------------------------------------------------------------------------

    @IsTest
    static void testSetDefaultIndustry_AssignsDefaultWhenBlank() {
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Acme', Industry = ''),
            new Account(Name = 'Beta', Industry = null)
        };

        AccountHandler1.setDefaultIndustry(accounts);

        for (Account a : accounts) {
            System.assertEquals('Technology', a.Industry,
                'Blank/null industry should be set to Technology');
        }
    }

    @IsTest
    static void testSetDefaultIndustry_PreservesExistingValue() {
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Existing', Industry = 'Finance')
        };

        AccountHandler1.setDefaultIndustry(accounts);

        System.assertEquals('Finance', accounts[0].Industry,
            'Pre-existing industry should not be overwritten');
    }

    @IsTest
    static void testSetDefaultIndustry_NullListIsHandledGracefully() {
        Test.startTest();
        AccountHandler1.setDefaultIndustry(null);
        Test.stopTest();
        // No exception means the null guard works correctly
        System.assert(true, 'Null list should not throw an exception');
    }

    // -------------------------------------------------------------------------
    // TriggerHandler recursion guard
    // -------------------------------------------------------------------------

    @IsTest
    static void testInsertAccount_RecursionGuardPreventsDoubleExecution() {
        // Insert 1 account to fire triggers; the handler's recursion guard
        // should prevent the afterInsert context from re-entering.
        Test.startTest();
        insert new Account(Name = 'Recursion Test', Industry = 'Technology');
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Account];
        // If recursion were not guarded, additional Accounts might be created.
        System.assertEquals(1, count,
            'Recursion guard should prevent duplicate Account creation');
    }
}
