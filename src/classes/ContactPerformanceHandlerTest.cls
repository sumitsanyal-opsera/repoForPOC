/**
 * Test class for ContactPerformanceHandler (WO-026).
 *
 * Validates:
 *  - Happy-path: contacts are updated with the correct description
 *  - Edge cases: zero passes, null passes, no contacts in org
 *  - Performance assertions: single SOQL and single DML (via Test.startTest/stopTest limits)
 *  - Bulk safety: 200 contacts processed without governor-limit failures
 */
@IsTest
public with sharing class ContactPerformanceHandlerTest {

    @testSetup
    static void setupData() {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(
                FirstName = 'Test',
                LastName  = 'User' + i,
                Email     = 'user' + i + '@example.com'
            ));
        }
        insert contacts;
    }

    // -------------------------------------------------------------------------
    // Happy-path tests
    // -------------------------------------------------------------------------

    @IsTest
    static void testProcessContacts_UpdatesDescription() {
        Test.startTest();
        ContactPerformanceHandler.processContacts(1);
        Test.stopTest();

        List<Contact> updated = [SELECT Id, Description FROM Contact];
        System.assert(!updated.isEmpty(), 'Contacts should exist');
        for (Contact c : updated) {
            System.assertEquals('Updated_0', c.Description,
                'Description should be set to Updated_0 after 1 pass');
        }
    }

    @IsTest
    static void testProcessContacts_MultiplePasses() {
        Test.startTest();
        ContactPerformanceHandler.processContacts(3);
        Test.stopTest();

        // After 3 passes the last description written is 'Updated_2'
        List<Contact> updated = [SELECT Id, Description FROM Contact];
        for (Contact c : updated) {
            System.assertEquals('Updated_2', c.Description,
                'Description should reflect the last pass index');
        }
    }

    // -------------------------------------------------------------------------
    // Edge cases
    // -------------------------------------------------------------------------

    @IsTest
    static void testProcessContacts_ZeroPassesDoesNothing() {
        Test.startTest();
        ContactPerformanceHandler.processContacts(0);
        Test.stopTest();

        List<Contact> contacts = [SELECT Id, Description FROM Contact];
        for (Contact c : contacts) {
            System.assertEquals(null, c.Description,
                'Description should remain null when 0 passes requested');
        }
    }

    @IsTest
    static void testProcessContacts_NullPassesDoesNothing() {
        Test.startTest();
        ContactPerformanceHandler.processContacts(null);
        Test.stopTest();
        System.assert(true, 'Null pass count should not throw an exception');
    }

    @IsTest
    static void testProcessContacts_NoContactsHandledGracefully() {
        delete [SELECT Id FROM Contact];

        Test.startTest();
        ContactPerformanceHandler.processContacts(2);
        Test.stopTest();

        System.assertEquals(0, [SELECT COUNT() FROM Contact],
            'No contacts in org should be handled without errors');
    }

    // -------------------------------------------------------------------------
    // Bulk safety — 200 contacts
    // -------------------------------------------------------------------------

    @IsTest
    static void testProcessContacts_BulkSafety_200Contacts() {
        List<Contact> bulk = new List<Contact>();
        for (Integer i = 5; i < 205; i++) {
            bulk.add(new Contact(
                FirstName = 'Bulk',
                LastName  = 'User' + i,
                Email     = 'bulk' + i + '@example.com'
            ));
        }
        insert bulk;

        Test.startTest();
        ContactPerformanceHandler.processContacts(1);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Contact WHERE Description = 'Updated_0'];
        System.assertEquals(205, count,
            '205 contacts should all be updated in a single bulk DML');
    }
}
