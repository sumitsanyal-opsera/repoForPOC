@IsTest
private class POC_ContactServiceTest {

    @IsTest
    static void testCreateAndFetchContact() {

        Id conId = POC_ContactService.createDummyContact('CI_CD_Contact');
        Contact con = POC_ContactService.getContactById(conId);

        System.assertNotEquals(null, conId, 'Contact Id should not be null');
        System.assertEquals('CI_CD_Contact', con.LastName, 'LastName mismatch');
        System.assertEquals(true, con.Email.contains('@'), 'Email not created correctly');
        System.assertEquals('POC_Contact_Account', con.Account.Name);
    }

    @IsTest
    static void testValidateEmail() {

        System.assertEquals(true, POC_ContactService.validateEmail('test@poc.com'));
        System.assertEquals(false, POC_ContactService.validateEmail('testpoc.com'));
        System.assertEquals(false, POC_ContactService.validateEmail(''));
    }
}