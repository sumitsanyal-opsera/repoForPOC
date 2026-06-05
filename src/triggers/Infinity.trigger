trigger Infinity on Opportunity (before update) {
    for(Opportunity opp:Trigger.new)
    {
        opp.amount=10000;
    }

}