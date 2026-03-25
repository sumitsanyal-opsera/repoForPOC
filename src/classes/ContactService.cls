public class ContactService {

    public static void setDefaultDescription(List<Contact> contactList) {

        if (contactList == null || contactList.isEmpty()) {
            return;
        }
    // New Test Comment
// Test comment
        for (Contact con : contactList) {
            if (con.Description == null) {
                con.Description = 'New Contact Created';
            }
        }
    }
}
