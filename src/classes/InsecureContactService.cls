class InsecureContactService {

    //  This method intentionally contains multiple security violations
    public  List<Contact> fetchAndUpdateContacts(String userInput, String newDescription) {

        // ------------------------------------------------------------
        // Apex SOQL Injection Violation
        // ------------------------------------------------------------
        // User-controlled input is directly concatenated into SOQL
        String vulnerableQuery =
            'SELECT Id, FirstName, LastName, Email ' +
            'FROM Contact ' +
            'WHERE LastName LIKE \'%' + userInput + '%\'';

        // Executing unsafe dynamic SOQL
        List<Contact> contacts = Database.query(vulnerableQuery);

        // ------------------------------------------------------------
        // Apex CRUD / FLS Violations
        // ------------------------------------------------------------
        // - No isAccessible() check before reading Contact
        // - No isUpdateable() check before updating Contact
        // - No field-level security checks before modifying fields
        for (Contact c : contacts) {
            c.Description = newDescription;   // Field updated without FLS check
        }

        // DML without CRUD permission validation
        update contacts;

        return contacts;
//Dummy comment
    }

    // Additional method to introduce Delete CRUD violation
    public  void deleteContactsByEmail(String emailFragment) {

        // SOQL Injection Violation (again, for rule certainty)
        String unsafeQuery =
            'SELECT Id FROM Contact WHERE Email LIKE \'%' + emailFragment + '%\'';

        List<Contact> contactsToDelete = Database.query(unsafeQuery);

        // CRUD Violation:
        // Delete operation without Schema.sObjectType.Contact.isDeletable()
        delete contactsToDelete;
    }
}
