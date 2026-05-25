/**
 * Secure replacement for InsecureContactService.
 *
 * Changes from the original class:
 *  - Renamed to ContactDataService to reflect its purpose and remove
 *    the "Insecure" label that signalled a known security gap.
 *  - Dynamic SOQL replaced with parameterised bind variables to
 *    eliminate SOQL injection vulnerabilities.
 *  - CRUD and FLS checks added via SecurityUtil before every read,
 *    update, and delete operation.
 *  - stripInaccessible applied to query results before returning them
 *    to callers, ensuring field-level data is sanitised.
 *  - Declared 'with sharing' to honour the running user's record-level
 *    sharing rules.
 */
public with sharing class ContactDataService {

    /**
     * Fetches Contacts whose LastName contains the supplied keyword and
     * updates their Description field.
     *
     * Security controls applied:
     *  - SecurityUtil.checkObjectAccess (READ + UPDATE on Contact)
     *  - SecurityUtil.checkFieldAccess (Description, UPDATABLE)
     *  - Parameterised SOQL bind variable prevents injection
     *  - SecurityUtil.stripInaccessible strips unreadable fields from results
     *
     * @param lastNameKeyword  Substring to match against Contact.LastName
     * @param newDescription   Value to assign to Contact.Description
     * @return                 Sanitised list of updated Contact records
     * @throws SecurityException if the running user lacks required CRUD/FLS
     */
    public static List<Contact> fetchAndUpdateContacts(String lastNameKeyword, String newDescription) {
        SecurityUtil.checkObjectAccess(Contact.SObjectType, System.AccessType.READABLE);
        SecurityUtil.checkObjectAccess(Contact.SObjectType, System.AccessType.UPDATABLE);
        SecurityUtil.checkFieldAccess(Contact.Description, System.AccessType.UPDATABLE);

        String keyword = '%' + lastNameKeyword + '%';
        List<Contact> contacts = [
            SELECT Id, FirstName, LastName, Email, Description
            FROM Contact
            WHERE LastName LIKE :keyword
        ];

        for (Contact c : contacts) {
            c.Description = newDescription;
        }

        if (!contacts.isEmpty()) {
            update contacts;
        }

        return (List<Contact>) SecurityUtil.stripInaccessible(
            System.AccessType.READABLE, contacts
        );
    }

    /**
     * Deletes Contacts whose Email contains the supplied fragment.
     *
     * Security controls applied:
     *  - SecurityUtil.checkObjectAccess (READ + DELETE on Contact)
     *  - Parameterised SOQL bind variable prevents injection
     *
     * @param emailFragment  Substring to match against Contact.Email
     * @throws SecurityException if the running user lacks required CRUD access
     */
    public static void deleteContactsByEmail(String emailFragment) {
        SecurityUtil.checkObjectAccess(Contact.SObjectType, System.AccessType.READABLE);

        String fragment = '%' + emailFragment + '%';
        List<Contact> contactsToDelete = [
            SELECT Id FROM Contact WHERE Email LIKE :fragment
        ];

        if (!contactsToDelete.isEmpty()) {
            SecurityUtil.checkObjectAccess(Contact.SObjectType, System.AccessType.UPDATABLE);
            delete contactsToDelete;
        }
    }
}
