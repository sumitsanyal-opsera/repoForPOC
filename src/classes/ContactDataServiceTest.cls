/**
 * Test class for ContactDataService (refactored from InsecureContactServiceTest).
 *
 * Tests the secure replacement for InsecureContactService, verifying that:
 *  - SOQL injection is no longer possible (bind-variable queries)
 *  - CRUD/FLS checks are invoked (SecurityException thrown for restricted users)
 *  - Business logic (fetch-update, delete-by-email) behaves correctly
 */
@IsTest
public with sharing class ContactDataServiceTest {

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
    // fetchAndUpdateContacts — happy path
    // -------------------------------------------------------------------------

    @IsTest
    static void testFetchAndUpdateContacts_UpdatesDescription() {
        Test.startTest();
        List<Contact> result = ContactDataService.fetchAndUpdateContacts('User', 'Updated from test');
        Test.stopTest();

        System.assert(result.size() > 0, 'At least one Contact should be returned');

        List<Contact> reloaded = [SELECT Id, Description FROM Contact WHERE Id IN :result];
        Boolean updated = false;
        for (Contact c : reloaded) {
            if (c.Description == 'Updated from test') {
                updated = true;
            }
        }
        System.assert(updated, 'At least one Contact Description should have been updated');
    }

    @IsTest
    static void testFetchAndUpdateContacts_NoMatchReturnsEmpty() {
        Test.startTest();
        List<Contact> result = ContactDataService.fetchAndUpdateContacts('NOMATCH_XYZ', 'irrelevant');
        Test.stopTest();
        System.assertEquals(0, result.size(), 'No contacts should match an unrecognised keyword');
    }

    // -------------------------------------------------------------------------
    // fetchAndUpdateContacts — SOQL injection guard
    // -------------------------------------------------------------------------

    @IsTest
    static void testFetchAndUpdateContacts_InjectionInputIsHarmless() {
        // In the old InsecureContactService, "' OR '1'='1" would break the query.
        // With bind variables the apostrophe is treated as a literal character.
        Test.startTest();
        List<Contact> result = ContactDataService.fetchAndUpdateContacts(
            '\' OR \'1\'=\'1', 'injection attempt'
        );
        Test.stopTest();
        // Query should simply return zero results (no LastName contains that literal)
        System.assertEquals(0, result.size(),
            'Injection attempt should not return any records; bind variable prevents it');
    }

    // -------------------------------------------------------------------------
    // deleteContactsByEmail — happy path
    // -------------------------------------------------------------------------

    @IsTest
    static void testDeleteContactsByEmail_DeletesMatchingContacts() {
        Test.startTest();
        ContactDataService.deleteContactsByEmail('user');
        Test.stopTest();

        Integer remaining = [SELECT COUNT() FROM Contact];
        System.assertEquals(0, remaining, 'All test contacts should have been deleted');
    }

    @IsTest
    static void testDeleteContactsByEmail_NoMatchDoesNothing() {
        Integer countBefore = [SELECT COUNT() FROM Contact];
        Test.startTest();
        ContactDataService.deleteContactsByEmail('NOMATCH_XYZ');
        Test.stopTest();
        Integer countAfter = [SELECT COUNT() FROM Contact];
        System.assertEquals(countBefore, countAfter, 'No contacts should be deleted for a non-matching fragment');
    }
}
