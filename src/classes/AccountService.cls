public with sharing class AccountService {
    public static List<Account> buildAccounts(
        List<String> accountNames
    ) {
        List<Account> accounts = new List<Account>();

        if (accountNames == null) return accounts;

        for (String accountName : accountNames) {
            if (!String.isBlank(accountName)) {
                accounts.add(
                    new Account(Name = accountName.trim())
                );
            }
        }

        return accounts;
    }

    public static Map<Id, Account> mapAccountsById(
        List<Account> accounts
    ) {
        Map<Id, Account> accountMap =
            new Map<Id, Account>();

        if (accounts == null) return accountMap;

        for (Account accountRecord : accounts) {
            if (accountRecord.Id != null) {
                accountMap.put(
                    accountRecord.Id,
                    accountRecord
                );
            }
        }

        return accountMap;
    }
}