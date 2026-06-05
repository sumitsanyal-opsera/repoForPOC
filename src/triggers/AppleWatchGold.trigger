trigger AppleWatchGold on Opportunity (after insert) {
    for(Opportunity opp:Trigger.new)
    {
        if(opp.amount>50000){
            Task t=new Task();
            t.Subject='Apple Watch Gold';
            t.Description='Send one ASAP';
            t.Priority='High';
            t.whatId=opp.Id;
            insert t;
        }
    }

}