trigger POC_ContactTrigger on Contact (before insert, before update) {
    //Test comments in the triggers
    POC_ContactTriggerHandler.beforeInsertUpdate(Trigger.new);
}