@IsTest
public class ContactPerformanceHandlerTest {

    @IsTest
    static void testProcessContacts_PerformanceViolations() {

        //  Violation: Test data created repeatedly without @testSetup
        for (Integer i = 0; i < 3; i++) {
            insert new Contact(
                FirstName = 'Test',
                LastName  = 'User' + i,
                Email     = 'user' + i + '@example.com'
            );
        }

        //  Violation: Re-querying test data unnecessarily
        List<Contact> contacts = [
            SELECT Id FROM Contact
        ];

        System.Test.startTest();

        //  Violation: Calling inefficient logic multiple times
        ContactPerformanceHandler.processContacts(2);
        ContactPerformanceHandler.processContacts(1);

        System.Test.stopTest();

        //  Violation: SOQL query without filters
        List<Contact> updatedContacts = [
            SELECT Id, Description
            FROM Contact
        ];

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
    static void testProcessContacts_RepeatedExecution() {


        //  Violation: No limits on repeated execution
        for (Integer i = 0; i < 2; i++) {
            ContactPerformanceHandler.processContacts(1);
        }

        System.Test.stopTest();

        //  Violation: No assertions validating behavior
    }
}
