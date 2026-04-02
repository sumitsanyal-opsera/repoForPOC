trigger wkcountIncrement on Account (before insert,before update) {
    List<account> accList=[Select id,name from Account];
    for(account acc:trigger.new)
    {
        if(acc.Name!=null && acc.wk_count__c>=1 )
        {
            acc.wk_count__c=acc.wk_count__c+1;
            accList.add(acc);
        }
        else
        {
            acc.wk_count__c=1;
            
        }
    }
    
}