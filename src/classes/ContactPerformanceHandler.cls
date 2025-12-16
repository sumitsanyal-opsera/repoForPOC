public class ContactPerformanceHandler {

    //  Performance + Complexity + Best Practice Violations:
    // - High cyclomatic & cognitive complexity
    // - SOQL inside loop
    // - DML inside loop
    // - Deep nested conditionals
    // - describe calls inside loop
    // - Repeated string concatenation
    // - Redundant logic branches
    // - No exception handling
    // - Excessive debug logging

    public static void processContacts(Integer recordCount) {

        Integer counter = 0;
        String auditLog = '';
        Boolean processFlag = true;     //  unnecessary flag
        Boolean secondaryFlag = false; //  unnecessary flag

        while (counter < recordCount) {

            //  Describe inside loop
            Map<String, Schema.SObjectType> globalMap = Schema.getGlobalDescribe();

            //  Redundant condition checks
            if (processFlag == true) {

                //  Unselective SOQL inside loop
                List<Contact> contacts = [
                    SELECT Id, FirstName, LastName, Email, Description
                    FROM Contact
                ];

                for (Contact c : contacts) {

                    //  Multiple nested conditionals
                    if (c.Email != null) {
                        if (c.LastName != null) {
                            if (c.LastName.length() > 0) {

                                //  String concatenation in loop
                                auditLog += c.LastName;

                                //  Switch statement for no real reason
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

                                //  Redundant boolean logic
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

                //  Redundant SOQL COUNT inside loop
                Integer totalContacts = [SELECT COUNT() FROM Contact];

                //  Nested branching with no real purpose
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
                //  Dead branch (never executed)
                System.debug('Process flag disabled');
            }

            //  Redundant logic to toggle flags
            if (counter % 2 == 0) {
                processFlag = true;
            } else {
                processFlag = true;
            }

            counter++;
        }

        //  Useless post-processing logic
        if (auditLog != null) {
            if (auditLog.length() >= 0) {
                System.debug('Audit log length: ' + auditLog.length());
            }
        }
    }
}
