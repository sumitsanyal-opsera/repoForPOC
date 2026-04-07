@isTest
public class ContactServiceTest {

    @isTest
    static void testSetDefaultDescription() {

        // Prepare test data
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe'),
            new Contact(FirstName = 'Jane', LastName = 'Smith', Description = 'Existing Description')
        };

        // Call the Apex class method
        ContactService.setDefaultDescription(contacts);

        // Assertions
        System.assertEquals(
            'New Contact Created',
            contacts[0].Description,
            'Description should be set for null value'
        );

        System.assertEquals(
            'Existing Description',
            contacts[1].Description,
            'Existing description should not be overwritten'
        );
    }
}