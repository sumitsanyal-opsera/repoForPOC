@isTest
public class LeadProcessorTest {
    @testSetup
    static void setup(){
        List<Lead> leads=new List<Lead>();
        for(Integer i=0;i<200;i++){
            leads.add(new Lead(FirstName='Test',LastName='Lead'+i,Company='Demo'+i));
        }
        insert leads;
    }
    static testMethod void test(){
        System.Test.startTest();
        LeadProcessor lp=new LeadProcessor();
        Id batchId=Database.executeBatch(lp);
        System.test.stopTest();
    }

}