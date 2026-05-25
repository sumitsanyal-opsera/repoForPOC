/**
 * Abstract base class for all Apex trigger handlers.
 *
 * Responsibilities
 * ----------------
 *  1. Dispatches the correct handler method based on Trigger context.
 *  2. Provides a static recursion guard so that a single transaction
 *     cannot re-enter the same handler class more than once, preventing
 *     infinite trigger loops caused by DML inside trigger logic.
 *  3. Enforces 'with sharing' to inherit the running user's record-level
 *     sharing rules in all concrete subclasses.
 *
 * Usage
 * -----
 * Create a concrete class that extends TriggerHandler and override only
 * the context methods you need (e.g. beforeInsert, afterUpdate).
 * From the trigger body, call:
 *
 *     new MyTriggerHandler().run();
 */
public abstract with sharing class TriggerHandler {

    // -------------------------------------------------------------------------
    // Recursion guard
    // -------------------------------------------------------------------------

    // Tracks handler class names that have already executed in this transaction
    private static Set<String> executedHandlers = new Set<String>();

    /**
     * Returns true if this handler class has already run in the current
     * transaction, false otherwise.
     */
    @TestVisible
    private Boolean isAlreadyExecuted() {
        return executedHandlers.contains(getHandlerName());
    }

    /**
     * Marks this handler class as having run in the current transaction.
     */
    private void markExecuted() {
        executedHandlers.add(getHandlerName());
    }

    /**
     * Returns the fully-qualified name of the concrete handler class.
     * Used as the key for the recursion guard set.
     */
    private String getHandlerName() {
        return String.valueOf(this).split(':')[0];
    }

    // -------------------------------------------------------------------------
    // Entry point
    // -------------------------------------------------------------------------

    /**
     * Main entry point called from the trigger body.
     * Checks the recursion guard, dispatches to the appropriate context
     * method, then marks this handler as executed.
     */
    public void run() {
        if (isAlreadyExecuted()) {
            return;
        }

        if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                beforeInsert();
            } else if (Trigger.isUpdate) {
                beforeUpdate();
            } else if (Trigger.isDelete) {
                beforeDelete();
            }
        } else if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                afterInsert();
            } else if (Trigger.isUpdate) {
                afterUpdate();
            } else if (Trigger.isDelete) {
                afterDelete();
            } else if (Trigger.isUndelete) {
                afterUndelete();
            }
        }

        markExecuted();
    }

    // -------------------------------------------------------------------------
    // Context methods — override in subclasses as needed
    // -------------------------------------------------------------------------

    @TestVisible protected virtual void beforeInsert()  {}
    @TestVisible protected virtual void beforeUpdate()  {}
    @TestVisible protected virtual void beforeDelete()  {}
    @TestVisible protected virtual void afterInsert()   {}
    @TestVisible protected virtual void afterUpdate()   {}
    @TestVisible protected virtual void afterDelete()   {}
    @TestVisible protected virtual void afterUndelete() {}
}
