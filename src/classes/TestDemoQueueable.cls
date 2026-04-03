public class TestDemoQueueable implements Queueable {
    public void execute(QueueableContext qCnxt){
        DELETE [Select Id from Case where createddate=Today];
    }

}