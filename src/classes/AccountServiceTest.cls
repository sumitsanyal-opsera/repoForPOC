@isTest
public class AccountServiceTest {

    @isTest
    static void testCreateAccount() {

        Test.startTest();
        Account acc = AccountService.createAccount('Test Account');
        Test.stopTest();

        System.assertNotEquals(null, acc.Id);
        System.assertEquals('Test Account', acc.Name);
    }
    
    // Added Test comment

    @isTest
    static void testGetAllAccounts() {

        Account acc = new Account(Name = 'Sample Account');
        insert acc;

        Test.startTest();
        List<Account> accList = AccountService.getAllAccounts();
        Test.stopTest();

        System.assert(accList.size() > 0);
    }
}