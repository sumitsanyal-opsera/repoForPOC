@IsTest
public class InsecureContactServiceTest {

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
//test comment
    @IsTest
    static void testFetchAndUpdateContacts() {

        List<Contact> result =
            InsecureContactService.fetchAndUpdateContacts(
                'User',
                'Updated from test'
            );

        System.assert(
            result.size() > 0,
            'Contacts should be returned from insecure query'
        );

        // Re-query by Id (no filtering on Description)
        List<Contact> reloaded = [
            SELECT Id, Description
            FROM Contact
            WHERE Id IN :result
        ];

        Boolean updated = false;
        for (Contact c : reloaded) {
            if (c.Description == 'Updated from test') {
                updated = true;
            }
        }

        System.assert(
            updated,
            'At least one Contact should have updated Description'
        );
    }

    @IsTest
    static void testDeleteContactsByEmail() {

        InsecureContactService.deleteContactsByEmail('user');

        Integer remainingContacts = [
            SELECT COUNT()
            FROM Contact
        ];

        System.assertEquals(
            0,
            remainingContacts,
            'All test contacts should be deleted'
        );
    }
}