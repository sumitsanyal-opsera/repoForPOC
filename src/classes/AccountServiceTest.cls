@IsTest
private class AccountServiceTest {

    @TestSetup
    static void createTestData() {

        List<Account> accounts = new List<Account>{
            new Account(
                Name = 'Enterprise Inc',
                AnnualRevenue = 15000000
            ),
            new Account(
                Name = 'Mid Market Ltd',
                AnnualRevenue = 2500000
            ),
            new Account(
                Name = 'Small Business',
                AnnualRevenue = 500000
            ),
            new Account(
                Name = 'No Revenue'
            )
        };

        insert accounts;
    }

    @IsTest
    static void testUpdateAccountRating() {

        Set<Id> accountIds = new Set<Id>();

        for (Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }

        System.Test.startTest();
        AccountService.updateAccountRating(accountIds);
        System.Test.stopTest();

        Map<String, Account> accountMap = new Map<String, Account>();

        for (Account acc : [
            SELECT Name, Rating
            FROM Account
        ]) {
            accountMap.put(acc.Name, acc);
        }

        System.assertNotEquals(null, accountMap.get('Enterprise Inc'));
        System.assertEquals('Hot', accountMap.get('Enterprise Inc').Rating);

        System.assertNotEquals(null, accountMap.get('Mid Market Ltd'));
        System.assertEquals('Warm', accountMap.get('Mid Market Ltd').Rating);

        System.assertNotEquals(null, accountMap.get('Small Business'));
        System.assertEquals('Cold', accountMap.get('Small Business').Rating);

        System.assertNotEquals(null, accountMap.get('No Revenue'));
        System.assertEquals('Cold', accountMap.get('No Revenue').Rating);
    }

    @IsTest
    static void testGetTotalRevenue() {

        Set<Id> accountIds = new Set<Id>();

        for (Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }

        System.Test.startTest();
        Decimal totalRevenue = AccountService.getTotalRevenue(accountIds);
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

        AccountService.updateAccountRating(new Set<Id>());

        Decimal revenue = AccountService.getTotalRevenue(new Set<Id>());

        System.Test.stopTest();

        System.assertEquals(
            0,
            revenue,
            'Revenue should be zero when no Account Ids are provided.'
        );
    }
}