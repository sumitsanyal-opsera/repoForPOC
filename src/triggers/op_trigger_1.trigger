trigger op_trigger_1 on Opportunity (before insert,before update) {
    for(Opportunity a:Trigger.new){
        if(a.amount <5000)
        {
            a.addError('Amount cannot be less than 5000');
        }
    }

}