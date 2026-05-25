/**
 * Shared test-data factory used by all test classes in this project.
 *
 * Centralises record creation so that schema changes only need a single update
 * here rather than across every test class.  All methods follow a consistent
 * convention:
 *
 *  - createXxx(...)  — builds and inserts the record, returns the saved SObject
 *  - buildXxx(...)   — builds the record in memory WITHOUT inserting (useful
 *                      when the caller needs to set additional fields before DML)
 *
 * Usage example:
 *   Contact c = TestDataFactory.createContact('Doe', 'jane@example.com');
 *   Account a = TestDataFactory.createAccount('Acme');
 *
 * This class is annotated @IsTest so it is never deployed to production.
 */
@IsTest
public class TestDataFactory {

    // -------------------------------------------------------------------------
    // Account
    // -------------------------------------------------------------------------

    public static Account buildAccount(String name) {
        return new Account(
            Name     = name,
            Industry = 'Technology'
        );
    }

    public static Account createAccount(String name) {
        Account a = buildAccount(name);
        insert a;
        return a;
    }

    public static List<Account> createAccounts(Integer count) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < count; i++) {
            accounts.add(buildAccount('Test Account ' + i));
        }
        insert accounts;
        return accounts;
    }

    // -------------------------------------------------------------------------
    // Contact
    // -------------------------------------------------------------------------

    public static Contact buildContact(String lastName, String email) {
        return new Contact(
            FirstName = 'Test',
            LastName  = lastName,
            Email     = email
        );
    }

    public static Contact createContact(String lastName, String email) {
        Contact c = buildContact(lastName, email);
        insert c;
        return c;
    }

    public static List<Contact> createContacts(Integer count) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < count; i++) {
            contacts.add(buildContact('User' + i, 'user' + i + '@example.com'));
        }
        insert contacts;
        return contacts;
    }

    // -------------------------------------------------------------------------
    // Project_Task__c
    // -------------------------------------------------------------------------

    public static Project_Task__c buildProjectTask(String name, String status) {
        return new Project_Task__c(
            Task_Name__c = name,
            Due_Date__c  = Date.today().addDays(7),
            Status__c    = status
        );
    }

    public static Project_Task__c createProjectTask(String name, String status) {
        Project_Task__c t = buildProjectTask(name, status);
        insert t;
        return t;
    }

    public static List<Project_Task__c> createProjectTasks(Integer count, String status) {
        List<Project_Task__c> tasks = new List<Project_Task__c>();
        for (Integer i = 0; i < count; i++) {
            tasks.add(buildProjectTask('Task ' + i, status));
        }
        insert tasks;
        return tasks;
    }

    // -------------------------------------------------------------------------
    // User (restricted profile — for SecurityUtil negative-path tests)
    // -------------------------------------------------------------------------

    public static User buildRestrictedUser(String alias) {
        Profile p;
        List<Profile> profiles = [
            SELECT Id FROM Profile
            WHERE Name IN ('Minimum Access - Salesforce', 'Read Only')
            LIMIT 1
        ];
        p = profiles.isEmpty()
            ? [SELECT Id FROM Profile WHERE Name = 'Read Only' LIMIT 1]
            : profiles[0];

        return new User(
            Alias             = alias,
            Email             = alias + '@testfactory.example.com',
            EmailEncodingKey  = 'UTF-8',
            LastName          = 'FactoryUser',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey      = 'en_US',
            ProfileId         = p.Id,
            TimeZoneSidKey    = 'America/New_York',
            UserName          = alias + '_' + UserInfo.getOrganizationId() + '@testfactory.example.com'
        );
    }

    public static User createRestrictedUser(String alias) {
        User u = buildRestrictedUser(alias);
        insert u;
        return u;
    }
}
