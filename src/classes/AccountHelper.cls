/**
 * Helper for fetching Account records and logging their details.
 */
public with sharing class AccountHelper {

    /**
     * Fetches Accounts the running user can read, ordered by Name.
     *
     * @return Sanitised list of Account records
     */
    public static List<Account> fetchAccounts() {
        SecurityUtil.checkObjectAccess(Account.SObjectType, System.AccessType.READABLE);

        List<Account> accounts = [
            SELECT Id, Name, Industry, Type, Phone, Website, BillingCity, BillingState
            FROM Account
            ORDER BY Name
            LIMIT 200
        ];

        return (List<Account>) SecurityUtil.stripInaccessible(
            System.AccessType.READABLE, accounts
        );
    }

    /**
     * Fetches Accounts and prints each record's details to the debug log.
     */
    public static void fetchAndPrintAccountDetails() {
        List<Account> accounts = fetchAccounts();
        System.debug(LoggingLevel.INFO, 'AccountHelper: fetched ' + accounts.size() + ' account(s)');

        for (Account acc : accounts) {
            printAccountDetails(acc);
        }
    }

    /**
     * Prints a single Account's details to the debug log.
     *
     * @param acc Account record to log
     */
    public static void printAccountDetails(Account acc) {
        if (acc == null) {
            System.debug(LoggingLevel.WARN, 'AccountHelper: cannot print null Account');
            return;
        }

        System.debug(LoggingLevel.INFO, formatAccountDetails(acc));
    }

    private static String formatAccountDetails(Account acc) {
        return 'Account{' +
            'Id=' + acc.Id +
            ', Name=' + acc.Name +
            ', Industry=' + acc.Industry +
            ', Type=' + acc.Type +
            ', Phone=' + acc.Phone +
            ', Website=' + acc.Website +
            ', BillingCity=' + acc.BillingCity +
            ', BillingState=' + acc.BillingState +
            '}';
    }
}