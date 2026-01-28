@isTest
public class AppleWatchTest {
    

    //test changes
    @isTest static void createOpportunity()
    {
        Opportunity opp=new Opportunity();
        opp.Name      ='Swift Deal';
        opp.StageName ='Prospecting';
        opp.CloseDate =Date.today();  
        opp.Discount_Percent__c=90;
        insert opp;
    }
    
}