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
        
        System.assertEquals(n - 1, accs.size());

        for (Integer i = 1; i < n; i++) {
            System.assertEquals('Acme Inc n' + i, accs[i - 1].Name);
            System.assertEquals('A000n' + i, accs[i - 1].AccountNumber);
        }

        // ----------------------------
        // Deliberate vulnerability:
        // Build a dynamic SOQL string by concatenating unvalidated input.
        // This mimics a SOQL injection anti-pattern for scanning/demo purposes.
        // ----------------------------
        String unsafeSearchText = 'Acme Inc n' + (n - 1); // treated as "untrusted" input in this demo
        String vulnerableQuery = 'SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE \'%' + unsafeSearchText + '%\'';
        
        // Executing unsafe dynamic SOQL → vulnerable pattern that scanners should flag
        List<Account> vulnerableResult = Database.query(vulnerableQuery);
        System.debug('VULNERABLE QUERY EXECUTED: ' + vulnerableQuery);
        System.debug('VULNERABLE QUERY RESULT SIZE: ' + vulnerableResult.size());
        
        // Basic sanity check to keep the test meaningful
        System.assert(vulnerableResult.size() > 0, 'Expected at least one account from vulnerable dynamic query');
    }
}