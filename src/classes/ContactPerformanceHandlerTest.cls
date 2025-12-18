@IsTest
public class ContactPerformanceHandlerTest {

    @IsTest
    static void testProcessContacts_PerformanceAndCRUDViolations() {

        //  Violation: Test data created repeatedly without @testSetup
        for (Integer i = 0; i < 3; i++) {

            //  CRUD/FLS Violation:
            //  Inserting Contact without checking create access
            insert new Contact(
                FirstName = 'Test',
                LastName  = 'User' + i,
                Email     = 'user' + i + '@example.com'
            );
        }

        //  CRUD Violation:
        //  SOQL executed without checking isAccessible()
        List<Contact> contacts = [
            SELECT Id, Email
            FROM Contact
        ];

        //  Violation: Calling inefficient logic multiple times
        ContactPerformanceHandler.processContacts(2);
        ContactPerformanceHandler.processContacts(1);

        

        //  CRUD/FLS Violation:
        //  Reading and updating fields without field-level security checks
        List<Contact> updatedContacts = [
            SELECT Id, Description
            FROM Contact
        ];

        for (Contact c : updatedContacts) {

            //  CRUD/FLS Violation:
            //  Updating records without update permission check
            c.Description = 'Updated by test';
        }

        //  CRUD Violation:
        //  DML update without Schema.sObjectType.Contact.isUpdateable()
        update updatedContacts;

        //  Violation: Inefficient loop just to assert existence
        Boolean found = false;
        for (Contact c : updatedContacts) {
            found = true;
        }

        //  Violation: Assertion without message
        System.assert(found);

        //  Violation: Debug in test class
        System.debug('Total contacts processed: ' + updatedContacts.size());
    }

    @IsTest
    static void testProcessContacts_RepeatedExecution_WithCRUDIssues() {

        //  Violation: Repeated execution without limits or assertions
        for (Integer i = 0; i < 2; i++) {
            ContactPerformanceHandler.processContacts(1);
        }

        //  CRUD Violation:
        //  Delete operation without delete permission check
        List<Contact> contactsToDelete = [
            SELECT Id
            FROM Contact
        ];

        delete contactsToDelete;

        System.Test.stopTest();

        //  Violation: No assertions validating behavior
    }
}
