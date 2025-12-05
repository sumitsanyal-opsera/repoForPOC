@isTest
public class AccountHandler1Test {
    
    @isTest
    static void testInsertAccount() {
        
        Integer n = 5;
        
        System.Test.startTest();
        AccountHandler1.insertAccount(n);
        System.Test.stopTest();
        
        List<Account> accs = [
            SELECT Id, Name, AccountNumber
            FROM Account
            WHERE Name LIKE 'Acme Inc n%'
        ];
        
        System.assertEquals(n - 1, accs.size())

        for (Integer i = 1; i < n; i++) {
            System.assertEquals('Acme Inc n' + i, accs[i - 1].Name);
            System.assertEquals('A000n' + i, accs[i - 1].AccountNumber);
        }
    }
}
