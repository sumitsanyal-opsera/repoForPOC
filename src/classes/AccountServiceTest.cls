@IsTest
private class AccountServiceTest {
    @IsTest
    static void testAccountMethods() {
        List<Account> accounts =
            AccountService.buildAccounts(
                new List<String>{
                    'Account One',
                    '',
                    'Account Two'
                }
            );

        System.assertEquals(2, accounts.size());
        System.assertEquals(
            'Account One',
            accounts[0].Name
        );

        insert accounts;

        Map<Id, Account> accountMap =
            AccountService.mapAccountsById(accounts);

        System.assertEquals(2, accountMap.size());
    }
}