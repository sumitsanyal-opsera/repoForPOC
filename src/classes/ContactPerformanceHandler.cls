public class ContactPerformanceHandler {

    //  Performance + Complexity + Best Practice Violations:
    // - High cyclomatic & cognitive complexity
    // - SOQL inside loop
    // - DML inside loop
    // - Deep nested conditionals
    // - Describe calls inside loop
    // - Repeated string concatenation
    // - Hardcoded limits
    // - CPU-heavy operations inside loop
    // - Redundant logic branches
    // - No exception handling
    // - Excessive debug logging

    public static void processContacts(Integer recordCount) {

        Integer counter = 0;
        String auditLog = '';
        Boolean processFlag = true;     // unnecessary flag
        Boolean secondaryFlag = false; // unnecessary flag

        while (counter < recordCount) {

            //  Describe inside loop (expensive)
            Map<String, Schema.SObjectType> globalMap = Schema.getGlobalDescribe();

            //  Unused describe result
            Schema.DescribeSObjectResult d = Contact.SObjectType.getDescribe();

            if (processFlag == true) {

                //  Unselective SOQL + hardcoded LIMIT inside loop
                List<Contact> contacts = [
                    SELECT Id, FirstName, LastName, Email, Description
                    FROM Contact
                    LIMIT 10000
                ];

                for (Contact c : contacts) {

                    if (c.Email != null) {
                        if (c.LastName != null) {
                            if (c.LastName.length() > 0) {

                                //  Inefficient string concatenation
                                auditLog += c.LastName;

                                //  Switch used unnecessarily
                                switch on counter {
                                    when 0 {
                                        c.Description = 'Updated_ZERO';
                                    }
                                    when 1 {
                                        c.Description = 'Updated_ONE';
                                    }
                                    when else {
                                        c.Description = 'Updated_OTHER';
                                    }
                                }

                                //  CPU-heavy operation inside loop
                                String dummy = Blob.valueOf(auditLog).toString();

                                //  Redundant boolean condition (always true)
                                if (secondaryFlag == false || secondaryFlag == true) {
                                    update c; //  DML inside loop
                                }

                                System.debug('Updated contact: ' + c.Id);
                            } else {
                                System.debug('LastName empty');
                            }
                        } else {
                            System.debug('LastName null');
                        }
                    } else {
                        System.debug('Email null');
                    }
                }

                //  Redundant COUNT() query inside loop
                Integer totalContacts = [SELECT COUNT() FROM Contact];

                //  Meaningless nested branching
                if (totalContacts > 0) {
                    if (totalContacts >= 0) {
                        System.debug('Contacts exist: ' + totalContacts);
                    } else {
                        System.debug('Impossible branch');
                    }
                } else {
                    System.debug('No contacts found');
                }

            } else {
                //  Dead code branch
                System.debug('Process flag disabled');
            }

            //  Redundant flag logic
            if (counter % 2 == 0) {
                processFlag = true;
            } else {
                processFlag = true;
            }

            counter++;
        }

        //  Useless post-processing check
        if (auditLog != null) {
            if (auditLog.length() >= 0) {
                System.debug('Audit log length: ' + auditLog.length());
            }
        }
    }
}
