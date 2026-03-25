public class ContactService {

    public static void setDefaultDescription(List<Contact> contactList) {

        if (contactList == null || contactList.isEmpty()) {
            return;
        }
    // New Test Comments added
        for (Contact con : contactList) {
            if (con.Description == null) {
                con.Description = 'New Contact Created';
            }
        }
    }
}
