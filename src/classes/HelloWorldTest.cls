@isTest
public class HelloWorldTest {
    @isTest static void updateLead(){
        //Test code goes here
   
        Lead mylead=new Lead();
        myLead.FirstName='Sumit';
        myLead.LastName='Sanyal';
        myLead.Company='Birlasoft';
        insert myLead;
        myLead.Company='Birlasoft';
        update myLead;
    }

}