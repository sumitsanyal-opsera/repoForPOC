public with sharing class AccountManager {

    /**
     * Updates the Account Type based on Annual Revenue.
     */
    public static void updateAccountType(Set<Id> accountIds) {

        if (accountIds == null || accountIds.isEmpty()) {
            return;
        }

        List<Account> accountsToUpdate = [
            SELECT Id, AnnualRevenue, Type
            FROM Account
            WHERE Id IN :accountIds
        ];

        for (Account acc : accountsToUpdate) {

            if (acc.AnnualRevenue == null) {
                acc.Type = 'Prospect';
            } else if (acc.AnnualRevenue >= 10000000) {
                acc.Type = 'Customer - Direct';
            } else if (acc.AnnualRevenue >= 1000000) {
                acc.Type = 'Customer - Channel';
            } else {
                acc.Type = 'Prospect';
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

    /**
     * Returns the total Annual Revenue of the given Accounts.
     */
    public static Decimal getTotalRevenue(Set<Id> accountIds) {

        if (accountIds == null || accountIds.isEmpty()) {
            return 0;
        }

        Decimal totalRevenue = 0;

        for (Account acc : [
            SELECT AnnualRevenue
            FROM Account
            WHERE Id IN :accountIds
        ]) {
            if (acc.AnnualRevenue != null) {
                totalRevenue += acc.AnnualRevenue;
            }
        }
        // Test Comment

        return totalRevenue;
    }
}