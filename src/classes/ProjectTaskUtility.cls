public with sharing class ProjectTaskUtility {
    
    // Method to mark all tasks as completed
    public static void completeAllTasks() {
        List<Project_Task__c> tasks = [
            SELECT Id, Status__c FROM Project_Task__c WHERE Status__c != 'Completed'
        ];
        for (Project_Task__c t : tasks) {
            t.Status__c = 'Completed';
        }
        if (!tasks.isEmpty()) {
            update tasks;
        }
    }

    // Method to get overdue tasks
    public static List<Project_Task__c> getOverdueTasks() {
        return [
            SELECT Id, Task_Name__c, Due_Date__c, Status__c
            FROM Project_Task__c
            WHERE Due_Date__c < :Date.today() AND Status__c != 'Completed'
        ];
    }
}