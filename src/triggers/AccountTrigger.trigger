// AccountTrigger.trigger
trigger AccountTrigger on Account (before insert, before update) {

    for (Account acc : Trigger.new) {

        // POC Logic using standard fields
        // Update Account Industry based on Rating

        if (acc.Rating == 'Hot') {
            acc.Industry = 'Technology';
        }
        else if (acc.Rating == 'Warm') {
            acc.Industry = 'Finance';
        }
        else {
            acc.Industry = 'Education';
        }
    }
}