trigger DedupeAccount on Account (after insert) {
    for(Account acc:Trigger.new)
    {
        Case c=new Case();
        c.OwnerId='0052v00000dlUXYAA2';
        c.Subject='Dedupe this account';
        c.AccountId=acc.Id;
        insert c;
    }

}