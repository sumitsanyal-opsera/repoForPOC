public class MJA_DummyAccountService {

    // Simple method to create Accounts
    public static List<Account> createDummyAccounts(Integer count) {
        List<Account> accountsToInsert = new List<Account>();

        for(Integer i = 0; i < count; i++) {
            Account acc = new Account();
            acc.Name = 'Dummy Account ' + i;
            acc.Industry = 'Technology';
            accountsToInsert.add(acc);
        }

        if(!accountsToInsert.isEmpty()) {
            insert accountsToInsert;
        }

        return accountsToInsert;
    }

    // Simple method to fetch accounts
    public static List<Account> fetchDummyAccounts(Integer limitSize) {
        return [
            SELECT Id, Name, Industry
            FROM Account
            ORDER BY CreatedDate DESC
            LIMIT :limitSize
        ];
    }

    // Simple update method for testing
    
    public static void updateDummyAccountName(Id accountId, String newName) {
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Name = newName;
        update acc;
    }
}