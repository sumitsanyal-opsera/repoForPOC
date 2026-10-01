trigger POC_ContactTrigger on Contact (before insert, before update) {
    //Test comment in the trigger
    POC_ContactTriggerHandler.beforeInsertUpdate(Trigger.new);
}