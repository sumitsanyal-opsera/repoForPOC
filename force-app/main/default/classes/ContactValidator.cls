/**
 * @description Validates Contact basic fields
 */
public class ContactValidator {
    
    /**
     * @description Validates Contact required fields
     * @param contacts List of Contact records to validate
     * @return Map<Id, List<String>> Map of Contact Id to validation errors
     */
    public static Map<Id, List<String>> validateContacts(List<Contact> contacts) {
        Map<Id, List<String>> validationErrors = new Map<Id, List<String>>();
        
        for (Contact contact : contacts) {
            List<String> errors = new List<String>();
            
            // Validate FirstName
            if (String.isBlank(contact.FirstName)) {
                errors.add('First Name is required');
            }
            
            // Validate LastName
            if (String.isBlank(contact.LastName)) {
                errors.add('Last Name is required');
            }
            
            // Validate Email format
            if (String.isNotBlank(contact.Email) && !isValidEmail(contact.Email)) {
                errors.add('Email format is invalid');
            }
            
            // Validate Phone format
            if (String.isNotBlank(contact.Phone) && !isValidPhone(contact.Phone)) {
                errors.add('Phone format is invalid');
            }
            
            // Validate AccountId
            if (contact.AccountId == null) {
                errors.add('Account is required');
            }
            
            if (!errors.isEmpty()) {
                validationErrors.put(contact.Id, errors);
            }
        }
        
        return validationErrors;
    }
    
    /**
     * @description Validates email format using a simple regex pattern
     * @param email Email address to validate
     * @return Boolean True if email is valid, false otherwise
     */
    private static Boolean isValidEmail(String email) {
        String emailRegex = '^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';
        Pattern p = Pattern.compile(emailRegex);
        Matcher m = p.matcher(email);
        return m.matches();
    }
    
    /**
     * @description Validates phone format (basic validation for 10+ digits)
     * @param phone Phone number to validate
     * @return Boolean True if phone is valid, false otherwise
     */
    private static Boolean isValidPhone(String phone) {
        String phoneRegex = '^[0-9\\s\\-\\+\\(\\)]{10,}$';
        Pattern p = Pattern.compile(phoneRegex);
        Matcher m = p.matcher(phone);
        return m.matches();
    }
}
