@isTest
private class WarrantySummaryTest {
    @isTest static void createCase(){
        Case myCase=new case();
        mycase.Product_Has_Extended_Warranty__c=true;
        myCase.Product_Purchase_Date__c=Date.today();
        myCase.Product_Total_Warranty_Days__c=5;
        myCase.Origin='Phone';
        insert myCase;
    }

}