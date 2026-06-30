@IsTest
private class AccountManagerTest {

    @TestSetup
    // Apex Test Class
    static void createTestData() {

        List<Account> accounts = new List<Account>{
            new Account(
                Name = 'Enterprise Account',
                AnnualRevenue = 15000000
            ),
            new Account(
                Name = 'Channel Account',
                AnnualRevenue = 2500000
            ),
            new Account(
                Name = 'Startup Account',
                AnnualRevenue = 500000
            ),
            new Account(
                Name = 'New Prospect'
            )
        };

        insert accounts;
    }

    @IsTest
    static void testUpdateAccountType() {

        Set<Id> accountIds = new Set<Id>();

        for (Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }

        System.Test.startTest();
        AccountManager.updateAccountType(accountIds);
        System.Test.stopTest();

        Map<String, Account> accountMap = new Map<String, Account>();

        for (Account acc : [
            SELECT Name, Type
            FROM Account
        ]) {
            accountMap.put(acc.Name, acc);
        }

        System.assertNotEquals(null, accountMap.get('Enterprise Account'));
        System.assertEquals(
            'Customer - Direct',
            accountMap.get('Enterprise Account').Type
        );

        System.assertNotEquals(null, accountMap.get('Channel Account'));
        System.assertEquals(
            'Customer - Channel',
            accountMap.get('Channel Account').Type
        );

        System.assertNotEquals(null, accountMap.get('Startup Account'));
        System.assertEquals(
            'Prospect',
            accountMap.get('Startup Account').Type
        );

        System.assertNotEquals(null, accountMap.get('New Prospect'));
        System.assertEquals(
            'Prospect',
            accountMap.get('New Prospect').Type
        );
    }

    @IsTest
    static void testGetTotalRevenue() {

        Set<Id> accountIds = new Set<Id>();

        for (Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }

        System.Test.startTest();
        Decimal totalRevenue = AccountManager.getTotalRevenue(accountIds);
        System.Test.stopTest();

        System.assertEquals(
            18000000,
            totalRevenue,
            'Total revenue should equal the sum of all AnnualRevenue values.'
        );
    }

    @IsTest
    static void testEmptyInput() {

        System.Test.startTest();

        AccountManager.updateAccountType(new Set<Id>());

        Decimal revenue = AccountManager.getTotalRevenue(new Set<Id>());

        System.Test.stopTest();

        System.assertEquals(
            0,
            revenue,
            'Revenue should be zero when no Account Ids are provided.'
        );
    }
}