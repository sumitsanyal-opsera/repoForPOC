public class ContactPerformanceHandler {

    //  Performance + Best Practice Violations:
    // - SOQL inside loop
    // - DML inside loop
    // - Nested loops
    // - describe calls inside loop
    // - Repeated String concatenation
    // - No bulkification
    // - No limit handling
    // - No exception handling
    // - Excessive debug logging

    public processContacts(Integer recordCount) {

        Integer counter = 0; //  Magic number
        String auditLog = ''; //  Inefficient string concatenation

        while (counter < recordCount) {

            //  Violation: Describe call inside loop (very expensive)
            Map<String, Schema.SObjectType> globalMap = Schema.getGlobalDescribe();

            //  Violation: Unselective SOQL inside loop
            List<Contact> contacts = [
                SELECT Id, FirstName, LastName, Email, Description
                FROM Contact
            ];

            for (Contact c : contacts) {

                //  Violation: String concatenation in loop
                auditLog += c.LastName;

                //  Violation: Hardcoded value
                c.Description = 'Updated_' + counter;

                //  Violation: DML inside inner loop
                update c;

                //  Violation: Debug inside nested loop
                System.debug('Updated contact: ' + c.Id);
            }

            //  Violation: Additional SOQL inside loop (redundant query)
            Integer totalContacts = [SELECT COUNT() FROM Contact];

            //  Violation: Debug log spam
            System.debug('Iteration ' + counter + ' processed. Total Contacts: ' + totalContacts);

            counter++;
        }

        //  Violation: Unused variable (auditLog never used)
        System.debug('Audit log size: ' + auditLog.length());
    }
}
