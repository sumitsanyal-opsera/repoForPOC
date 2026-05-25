/**
 * Bulk-safe Contact processing handler.
 *
 * Changes from the original class:
 *  - Schema.getGlobalDescribe() moved outside the loop (was called every iteration)
 *  - SOQL moved outside the loop (was causing N+1 queries per iteration)
 *  - DML collected into a list and executed once after all records are processed
 *  - String concatenation replaced with List<String> + String.join() for auditLog
 *  - Redundant COUNT query inside loop removed
 *  - SecurityUtil.checkObjectAccess called before SOQL/DML
 *  - SecurityUtil.stripInaccessible applied to query results
 *  - Declared with sharing
 */
public with sharing class ContactPerformanceHandler {

    /**
     * Processes all existing Contacts by appending a sequential description
     * for each pass up to recordCount.
     *
     * Governor-limit safe:
     *  - 1 SOQL query total (outside any loop)
     *  - 1 DML statement total (bulk update after all iterations)
     *  - No describe calls inside loops
     *
     * @param recordCount  Number of processing passes to execute
     */
    public static void processContacts(Integer recordCount) {
        if (recordCount == null || recordCount <= 0) {
            return;
        }

        SecurityUtil.checkObjectAccess(Contact.SObjectType, System.AccessType.READABLE);
        SecurityUtil.checkObjectAccess(Contact.SObjectType, System.AccessType.UPDATABLE);
        SecurityUtil.checkFieldAccess(Contact.Description, System.AccessType.UPDATABLE);

        // Single SOQL outside all loops
        List<Contact> contacts = (List<Contact>) SecurityUtil.stripInaccessible(
            System.AccessType.READABLE,
            [SELECT Id, FirstName, LastName, Email, Description FROM Contact]
        );

        if (contacts.isEmpty()) {
            return;
        }

        List<String> auditLogParts = new List<String>();

        // Processing passes — no SOQL or DML inside the loop
        for (Integer i = 0; i < recordCount; i++) {
            for (Contact c : contacts) {
                auditLogParts.add(c.LastName);
                c.Description = 'Updated_' + i;
            }
        }

        // Single bulk DML after all processing
        update contacts;

        System.debug(LoggingLevel.INFO,
            'ContactPerformanceHandler: processed ' + contacts.size() +
            ' contacts over ' + recordCount + ' passes. ' +
            'Audit log length: ' + String.join(auditLogParts, ',').length()
        );
    }
}
