trigger POC_ContactTrigger on Contact (before insert, before update) {
    POC_ContactTriggerHandler.beforeInsertUpdate(Trigger.new);
}