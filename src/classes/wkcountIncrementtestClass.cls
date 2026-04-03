@isTest
public class wkcountIncrementtestClass
{
    @isTest
    public static void runTest() {
        {
            System.Test.startTest();
            Account acc = new Account(Name='Test Account 6', Rating='Warm');
            insert acc;
            acc.Name='Test Acc5';
            update acc;
            System.Test.stopTest();
            
        }
    }
}