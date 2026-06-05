trigger duplicateAccount on Account (before insert,before update)
{
list<account> lst_acc=[Select id,name from Account];
    for(Account acc: trigger.new)
    {
        for(Account acc1:lst_acc)
        {
            if(acc.name==acc1.name)
            {
                acc.name.addError('This is a duplicate record');
            }
        }
    }

}