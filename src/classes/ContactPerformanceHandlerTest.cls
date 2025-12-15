@IsTest
public class ContactPerformanceHandlerTest {

    @IsTest
    static void testProcessContacts_Violations() {

        //  Violation: Test data created inline without @testSetup
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(
                new Contact(
                    FirstName = 'Test',
                    LastName  = 'User' + i,
                    Email     = 'test' + i + '@example.com'
                )
            );
        }
        insert testContacts;

        //  Violation: Magic number in test
        System.Test.startTest();

        //  Violation: Test depends on inefficient production logic
        ContactPerformanceHandler.processContacts(2);

        System.Test.stopTest();

        //  Violation: Unfiltered SOQL in test
        List<Contact> updatedContacts = [
            SELECT Id, Description
            FROM Contact
        ];

        //  Violation: Assertion without message
        System.assert(updatedContacts.size() > 0);

        //  Violation: Debug in test
        System.debug('Updated contacts count: ' + updatedContacts.size());
    }

    @IsTest
    static void testProcessContacts_NoAssertions() {

        System.Test.startTest();

        //  Violation: No negative scenario validation
        ContactPerformanceHandler.processContacts(1);

        System.Test.stopTest();

        //  Violation: No assertions at all
    }
}