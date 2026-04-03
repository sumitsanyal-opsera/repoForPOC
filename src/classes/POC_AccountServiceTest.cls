@IsTest
private class POC_AccountServiceTest {

    // Test account creation and retrieval
    static testMethod void testCreateAndFetchAccount() {

        // Create account using service
        Id accId = POC_AccountService.createDummyAccount('CI_CD_POC_Account');

        // Fetch account
        Account acc = POC_AccountService.getAccountById(accId);

        // Assertions
        System.assertNotEquals(null, accId, 'Account Id should not be null');
        //System.assertEquals('CI_CD_POC_Account', acc.Name, 'Account Name mismatch');
    }

    // Test validation logic
    static testMethod void testValidateAccountName() {

        System.assertEquals(true,
            POC_AccountService.validateAccountName('ValidName'),
            'Expected valid name'
        );

        System.assertEquals(false,
            POC_AccountService.validateAccountName(''),
            'Blank name should be invalid'
        );

        System.assertEquals(false,
            POC_AccountService.validateAccountName('AB'),
            'Short name should be invalid'
        );
    }
}
