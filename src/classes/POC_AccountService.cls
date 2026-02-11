public with sharing class POC_AccountService {

    // Creates a test Account
    public static Id createDummyAccount(String accName) {
        Account acc = new Account();
        acc.Name = accName;
        insert acc;
        return acc.Id;
    }

    // Fetches an Account by Id
    public static Account getAccountById(Id accId) {
        return [SELECT Id, Name, CreatedDate FROM Account WHERE Id = :accId LIMIT 1];
    }

    // Dummy validation method
    public static Boolean validateAccountName(String accName) {
        return (!String.isBlank(accName) && accName.length() >= 3);
    }
}