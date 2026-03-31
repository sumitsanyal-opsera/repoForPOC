@isTest
public class TestTriggerTest {

    @isTest
    static void testContactTrigger() {

        // Create test data
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe'
        );

        // Insert record
        insert testContact;

        // Fetch inserted record
        Contact insertedContact = [
            SELECT Id, Description
            FROM Contact
            WHERE Id = :testContact.Id
        ];

        // Assert expected result
        System.assertEquals(
            'New Contact Created',
            insertedContact.Description,
            'Description should be set by trigger'
        );
    }
}