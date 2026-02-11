public class POC_ContactTriggerHandler {

    public static void beforeInsertUpdate(List<Contact> newList) {
        for (Contact con : newList) {
            if (String.isBlank(con.Description)) {
                con.Description = 'POC Trigger executed via CI-CD pipeline';
            }
        }
    }
}