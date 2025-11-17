public with sharing class ProjectTaskService {
    
    // Method to create a new Project Task
    public static Id createTask(String name, Date dueDate, String status) {
        Project_Task__c newTask = new Project_Task__c(
            Task_Name__c = name,
            Due_Date__c = dueDate,
            Status__c = status
        );
        insert newTask;
        return newTask.Id;
    }

    // Method to update the status of a task
    public static void updateTaskStatus(Id taskId, String newStatus) {
        Project_Task__c task = [SELECT Id, Status__c FROM Project_Task__c WHERE Id = :taskId LIMIT 1];
        task.Status__c = newStatus;
        update task;
    }
}