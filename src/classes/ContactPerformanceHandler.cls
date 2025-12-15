public class ContactPerformanceHandler {

    //  Violation: Public static method doing SOQL + DML + business logic together
    //  Violation: No input validation
    //  Violation: No exception handling
    public static void processContacts(Integer recordCount) {

        //  Violation: Magic number
        Integer counter = 0;

        //  Violation: SOQL inside loop (performance anti-pattern)
        while (counter < recordCount) {

            //  Violation: Query without selective filters
            List<Contact> contacts = [
                SELECT Id, FirstName, LastName, Email
                FROM Contact
            ];

            //  Violation: DML inside loop
            //Dummy comment
            for (Contact c : contacts) {

                //  Violation: Hardcoded string
                c.Description = 'Updated by handler';

                //  Violation: Update inside nested loop
                update c;
            }

            //  Violation: Excessive debug logging
            System.debug('Processed iteration: ' + counter);

            counter++;
        }
    }
}