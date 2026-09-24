@IsTest
private class POC_ContactTriggerTest {

    @IsTest
    static void testTriggerPopulatesDescription() {

        Account acc = new Account(Name='POC Trigger Account');
        insert acc;

        Contact con = new Contact(
            LastName = 'TriggerPOC',
            AccountId = acc.Id
        );
        insert con;

        // Fetch inserted record
        Contact insertedCon = [
            SELECT Description 
            FROM Contact 
            WHERE Id = :con.Id
        ];

        System.assertEquals(
            'POC Trigger executed via CI-CD pipeline',
            insertedCon.Description
        );
    }
}