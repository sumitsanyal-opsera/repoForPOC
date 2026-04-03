public class TestDemoContactUpdate implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select id,lastname from Contact');
        
    }
    public void execute(Database.BatchableContext bc,List<Contact> listToUpdate){
        for(Contact con:listToUpdate){
            con.lastname='Batch Update-'+con.lastname;
        }
        update listToUpdate;
    }
    public void finish(Database.BatchableContext bc){
        
    }

}