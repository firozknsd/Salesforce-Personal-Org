public with sharing class ShowProjectTaskStatusController {
    public ShowProjectTaskStatusController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Project__c> projectTaskList(Id projectId) {
        String query = 'SELECT Id, Name, Completed__c, Completion_Date__c, Project__c, Type__c FROM Project_Task__c WHERE Project__c = \'' + projectId +'\'';
        return Database.query(query);
    }
}