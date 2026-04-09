@isTest
public class AppleWatchGoldTest {
    @isTest static void createOpportunity()
    {
        Opportunity opp=new Opportunity();
        opp.Name      ='Swift Deal';
        opp.StageName ='Prospecting';
        opp.CloseDate =Date.today();  
        opp.Discount_Percent__c=90;
        opp.Amount=55000;
        insert opp;
    }

}