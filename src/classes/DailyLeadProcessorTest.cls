@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP='0 0 0 4 10 ? 2020';
    static testmethod void testScheduledJob(){
        List<Lead> lList=new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead l=new Lead(lastname='Dreamforce'+i,Status='Open - Not Contacted',Company='Test Company'+i);
            lList.add(l);
        }
        insert lList;
        System.test.startTest();
        String jobId=System.schedule('LeadSource Update',CRON_EXP,new DailyLeadProcessor());
        System.test.stopTest();
        
    }

}