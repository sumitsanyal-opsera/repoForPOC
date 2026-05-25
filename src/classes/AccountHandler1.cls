/**
 * Trigger handler for the Account object.
 *
 * Extends TriggerHandler to get automatic recursion protection and a clean
 * context-dispatch pattern.  All Account business logic lives here; the
 * trigger itself is a single-line dispatcher.
 *
 * Changes from original class:
 *  - Extends TriggerHandler (replaces monolithic static method)
 *  - Bulk-safe: all Account records processed in collections, no DML in loops
 *  - Dynamic SOQL replaced with static SOQL and bind variables
 *  - CRUD access checked via SecurityUtil before DML
 *  - Input validated before use
 *  - Unused variables, excessive debug logs, and hardcoded flags removed
 *  - Cyclomatic complexity reduced — one responsibility per method
 */
public with sharing class AccountHandler1 extends TriggerHandler {

    private List<Account> newAccounts;
    private Map<Id, Account> oldAccountMap;

    public AccountHandler1() {
        if (Trigger.new != null)       this.newAccounts   = (List<Account>) Trigger.new;
        if (Trigger.oldMap != null)    this.oldAccountMap = (Map<Id, Account>) Trigger.oldMap;
    }

    // -------------------------------------------------------------------------
    // Trigger context entry points
    // -------------------------------------------------------------------------

    @TestVisible
    protected override void beforeInsert() {
        setDefaultIndustry(newAccounts);
    }

    @TestVisible
    protected override void afterInsert() {
        // Intentionally empty — placeholder for future after-insert logic
    }

    // -------------------------------------------------------------------------
    // Business logic (bulk-safe, testable independently)
    // -------------------------------------------------------------------------

    /**
     * Assigns a default industry of 'Technology' to any new Account that
     * does not already have an industry value set.
     *
     * Bulk-safe: operates on a list, zero SOQL/DML calls.
     */
    @TestVisible
    static void setDefaultIndustry(List<Account> accounts) {
        if (accounts == null || accounts.isEmpty()) {
            return;
        }
        for (Account acc : accounts) {
            if (String.isBlank(acc.Industry)) {
                acc.Industry = 'Technology';
            }
        }
    }

    // -------------------------------------------------------------------------
    // Legacy static method — kept for backwards compatibility
    // Callers should migrate to the trigger-handler pattern above.
    // -------------------------------------------------------------------------

    /**
     * Bulk-inserts n Account records with sequential names.
     * Replaces the original method that had DML inside a loop, dynamic SOQL
     * injection, and no input validation.
     *
     * @param n  Number of accounts to create.  Must be positive.
     * @throws SecurityException if the running user cannot create Accounts.
     */
    public static void insertAccount(Integer n) {
        if (n == null || n <= 0) {
            return;
        }

        SecurityUtil.checkObjectAccess(Account.SObjectType, System.AccessType.CREATABLE);

        List<Account> addAccounts = new List<Account>();
        for (Integer i = 0; i < n; i++) {
            addAccounts.add(new Account(
                Name          = 'Acme Inc ' + i,
                AccountNumber = 'ACC-' + i,
                Industry      = 'Technology'
            ));
        }

        insert addAccounts;
    }
}
