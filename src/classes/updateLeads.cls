global class updateLeads implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([Select AnnualRevenue from Lead]);
    }
    global void execute(Database.BatchableContext b,List<Lead> lList)
    {
        for(Lead l:lList)
        {
            if(l.AnnualRevenue==null)
            {
                l.AnnualRevenue=20000000;
            }
        }
        update lList;
    }
    global void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        String[] toAddress=new String[]{'sum31850@gmail.com'};
        mail.setToAddresses(toAddress);
        mail.setSubject('Congratulations!!!! Batch job is completed');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}