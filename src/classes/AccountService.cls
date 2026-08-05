public with sharing class AccountService {

    /**
     * Updates Account Rating based on Annual Revenue
     * >= 10M  -> Hot
     * >= 1M   -> Warm
     * < 1M    -> Cold
     */
    public static void updateAccountRating(Set<Id> accountIds) {

        if (accountIds == null || accountIds.isEmpty()) {
            return;
        }

        List<Account> accountsToUpdate = [
            SELECT Id, AnnualRevenue, Rating
            FROM Account
            WHERE Id IN :accountIds
        ];

        for (Account acc : accountsToUpdate) {

            if (acc.AnnualRevenue == null) {
                acc.Rating = 'Cold';
            }
            else if (acc.AnnualRevenue >= 10000000) {
                acc.Rating = 'Hot';
            }
            else if (acc.AnnualRevenue >= 1000000) {
                acc.Rating = 'Warm';
            }
            else {
                acc.Rating = 'Cold';
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

    /**
     * Returns the total Annual Revenue for the given Accounts
     */
    public static Decimal getTotalRevenue(Set<Id> accountIds) {

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

        return totalRevenue;
    }
}