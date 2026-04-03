public class TestDemoAccountUpdate implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select id,name from Account');
    }
    public void execute(Database.BatchableContext bc, List<Account> listToUpdate){
        for(Account acc:listToUpdate){
            acc.name='I am updating the Batch';
        }
        update listToUpdate;
    }
    public void finish(Database.BatchableContext bc){
        Database.executeBatch(new TestDemoContactUpdate(),100);
        //System.debug('Batch Class executed');
    }

}