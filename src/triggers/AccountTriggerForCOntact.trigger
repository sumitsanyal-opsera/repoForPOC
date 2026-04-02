trigger AccountTriggerForCOntact on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        System.enqueueJob(new ContactCreationQueueable(Trigger.new));
    }

}