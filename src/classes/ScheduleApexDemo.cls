public class ScheduleApexDemo implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Account> accList=[Select id, name from Account where createddate=Today];
        for(Account acc:accList){
            acc.name='Created Today-'+acc.name;
        }
        update accList;
    }

}