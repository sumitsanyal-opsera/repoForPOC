public with sharing class POC_ContactService {

    // Create a Contact linked to an Account
    public static Id createDummyContact(String lastName) {
        Account acc = new Account(Name = 'POC_Contact_Account');
        insert acc;

        Contact con = new Contact(
            LastName = lastName,
            AccountId = acc.Id,
            Email = lastName.toLowerCase() + '@poc.com'
        );
        insert con;

        return con.Id;
    }

    // Fetch Contact by Id
    public static Contact getContactById(Id conId) {
        return [
            SELECT Id, LastName, Email, Account.Name
            FROM Contact
            WHERE Id = :conId
            LIMIT 1
        ];
    }

    // Dummy validation logic
    public static Boolean validateEmail(String email) {
        return (!String.isBlank(email) && email.contains('@'));
    }
}