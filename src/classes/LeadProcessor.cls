global class LeadProcessor implements Database.Batchable<sObject> {
    
    //global Integer leadRecords=0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select ID,LeadSource from Lead]);        
    }

    //Lead Processor Apex class
    
    global void execute(Database.BatchableContext bc,List<Lead> scope){
        
        for(Lead lead:scope){
            lead.LeadSource='Dreamforce';
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc){
        
    }
    
}