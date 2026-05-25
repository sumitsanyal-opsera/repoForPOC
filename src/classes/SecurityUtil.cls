/**
 * Centralised CRUD/FLS enforcement utility.
 *
 * Every service and handler class that performs DML or SOQL MUST call the
 * appropriate check method here before acting on data. This enforces the
 * four-zone defence-in-depth model described in the project architecture.
 *
 * Design notes:
 *  - Declared 'with sharing' to inherit the running user's record-level
 *    sharing rules wherever this utility is invoked.
 *  - All methods are static; no instance state required.
 *  - Throws SecurityException (separate top-level class) so callers can
 *    catch access-denial errors without importing SecurityUtil.
 */
public with sharing class SecurityUtil {

    // -------------------------------------------------------------------------
    // Object-level (CRUD) checks
    // -------------------------------------------------------------------------

    /**
     * Verifies that the running user has the required CRUD permission on the
     * given SObject type.  Throws SecurityException with a descriptive message
     * if access is denied.
     *
     * @param objectType  The SObject schema type to check (e.g. Contact.SObjectType)
     * @param access      The operation to validate (READ, CREATE, EDIT, UPSERT, DELETE, UNDELETE)
     */
    public static void checkObjectAccess(Schema.SObjectType objectType, System.AccessType access) {
        Schema.DescribeSObjectResult describe = objectType.getDescribe();
        Boolean permitted = false;

        if (access == System.AccessType.READABLE) {
            permitted = describe.isAccessible();
        } else if (access == System.AccessType.CREATABLE) {
            permitted = describe.isCreateable();
        } else if (access == System.AccessType.UPDATABLE) {
            permitted = describe.isUpdateable();
        } else if (access == System.AccessType.UPSERTABLE) {
            permitted = describe.isCreateable() && describe.isUpdateable();
        }

        if (!permitted) {
            throw new SecurityException(
                'Insufficient CRUD access on ' + describe.getName() +
                ' for ' + access.name() + ' operation'
            );
        }
    }

    // -------------------------------------------------------------------------
    // Field-level security (FLS) checks
    // -------------------------------------------------------------------------

    /**
     * Verifies that the running user has the required FLS permission on the
     * given SObject field.  Throws SecurityException if access is denied.
     *
     * @param field   The SObject field token to check (e.g. Contact.Email)
     * @param access  The operation to validate (READ, CREATE, EDIT)
     */
    public static void checkFieldAccess(Schema.SObjectField field, System.AccessType access) {
        Schema.DescribeFieldResult describe = field.getDescribe();
        Boolean permitted = false;

        if (access == System.AccessType.READABLE) {
            permitted = describe.isAccessible();
        } else if (access == System.AccessType.CREATABLE) {
            permitted = describe.isCreateable();
        } else if (access == System.AccessType.UPDATABLE) {
            permitted = describe.isUpdateable();
        }

        if (!permitted) {
            throw new SecurityException(
                'Insufficient FLS access on ' + describe.getName() +
                ' for ' + access.name() + ' operation'
            );
        }
    }

    // -------------------------------------------------------------------------
    // Security.stripInaccessible wrapper
    // -------------------------------------------------------------------------

    /**
     * Strips fields the running user cannot access, then returns the sanitised
     * records.  Logs the strip operation for audit purposes.
     *
     * Use this instead of calling Security.stripInaccessible() directly so
     * that all strip operations go through one auditable code path.
     *
     * @param access   The access type context (e.g. READABLE for queries)
     * @param records  The SObject records to sanitise
     * @return         Sanitised SObject records with inaccessible fields removed
     */
    public static List<SObject> stripInaccessible(System.AccessType access, List<SObject> records) {
        if (records == null || records.isEmpty()) {
            return new List<SObject>();
        }

        SObjectAccessDecision decision = Security.stripInaccessible(access, records);

        if (!decision.getRemovedFields().isEmpty()) {
            System.debug(LoggingLevel.INFO,
                'SecurityUtil.stripInaccessible: removed fields ' +
                decision.getRemovedFields() +
                ' for access type ' + access.name()
            );
        }

        return decision.getRecords();
    }
}
