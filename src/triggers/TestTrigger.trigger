trigger TestTrigger on Contact (before insert) {
    for (Contact con : Trigger.new) {
        if (con.Description == null) {
            con.Description = 'New Contact Created';
        }
    }
}