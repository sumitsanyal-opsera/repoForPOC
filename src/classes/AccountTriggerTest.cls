// AccountTriggerTest.cls
@isTest
public class AccountTriggerTest {

    @isTest
    static void testBeforeInsert() {

        List<Account> accList = new List<Account>();

        accList.add(new Account(
            Name = 'POC Hot Account',
            Rating = 'Hot'
        ));

        accList.add(new Account(
            Name = 'POC Warm Account',
            Rating = 'Warm'
        ));

        accList.add(new Account(
            Name = 'POC Cold Account',
            Rating = 'Cold'
        ));

        System.Test.startTest();
        insert accList;
        System.Test.stopTest();

        List<Account> insertedAccounts = [
            SELECT Id, Name, Rating, Industry
            FROM Account
            WHERE Name LIKE 'POC%'
        ];

        for (Account acc : insertedAccounts) {

            if (acc.Rating == 'Hot') {

                System.assertEquals(
                    'Technology',
                    acc.Industry,
                    'Industry should be Technology for Hot accounts'
                );
            }
            else if (acc.Rating == 'Warm') {

                System.assertEquals(
                    'Finance',
                    acc.Industry,
                    'Industry should be Finance for Warm accounts'
                );
            }
            else {

                System.assertEquals(
                    'Education',
                    acc.Industry,
                    'Industry should be Education for Cold accounts'
                );
            }
        }
    }

    @isTest
    static void testBeforeUpdate() {

        Account acc = new Account(
            Name = 'Update POC Account',
            Rating = 'Cold'
        );

        insert acc;

        // Update Rating
        acc.Rating = 'Hot';

        System.Test.startTest();
        update acc;
        System.Test.stopTest();

        Account updatedAcc = [
            SELECT Id, Rating, Industry
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(
            'Technology',
            updatedAcc.Industry,
            'Industry should update correctly when Rating changes'
        );
    }
}