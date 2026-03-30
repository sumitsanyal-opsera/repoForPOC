public class DailyLeadProcessor implements schedulable {
    public void execute(SchedulableContext cxt){
        List<Lead> leadList=[Select id,name,LeadSource from Lead where LeadSource=Null];
        if(!leadList.isEmpty()){
            for(Lead l:leadList){
                l.LeadSource='Dreamforces';
            }
            update leadList;            
            
        }
        
    }
    
}
