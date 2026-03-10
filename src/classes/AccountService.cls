public class AccountService {

    public static Account createAccount(String accName) {
        Account acc = new Account();
        acc.Name = accName;
        insert acc;
        return acc;
    }
    // New Apex class
    // Dummy comment
    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name FROM Account LIMIT 10];
    }

}