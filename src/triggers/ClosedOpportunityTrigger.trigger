trigger ClosedOpportunityTrigger on Opportunity (before insert,before update) {
    List<Task> taskList=new List<Task>();
    for(Opportunity opp:Trigger.new){        
        if(opp.StageName=='Closed Won'){
            opp.Discount_Percent__c=12;
            taskList.add(new Task(Subject='Follow Up Test Task',WhatId=opp.Id));
        }  
    }
    if(taskList.size()>0)
    {
        insert taskList;
    }

}