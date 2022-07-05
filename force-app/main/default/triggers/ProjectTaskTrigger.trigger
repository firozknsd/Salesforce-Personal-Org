/*
		Name 		:	ProjectTaskTrigger
		Date 		:	08 June 2021
		Author 		:	Firoz Khan Agwan
		Description :	Trigger to validate project tasks.
		Helper		:	ProjectTaskTriggerHelper
*/
trigger ProjectTaskTrigger on Project_Task__c (before update, after update) {
    List <Project_Task__c> projectTasksToNextValidateList = new List<Project_Task__c>();
    List <Project_Task__c> validateProjectTasksList = new List<Project_Task__c>();
    Set <Id> projectIds = new Set<Id>();
    
    for(Project_Task__c projectTask : Trigger.new) {
        Boolean oldCompleted = Trigger.oldMap.get(projectTask.Id).Completed__c;
        if(Trigger.isBefore) {
            if(projectTask.Completed__c != oldCompleted) {
                if(projectTask.Completed__c) {
                    if(projectTask.Completion_Date__c == NULL) {
                        projectTask.Completion_Date__c.addError('Date is required..'); 
                    } else {
                    	validateProjectTasksList.add(projectTask);    
                    }
                } else {
                    if(projectTask.Completion_Date__c != NULL){
                        projectTask.Completion_Date__c.addError('Date is not required.'); 
                    }
                    //projectTasksToNextValidateList.add(projectTask);
                }
            }
        }
        if(projectTask.Completed__c != oldCompleted && Trigger.isAfter){
            projectIds.add(projectTask.Project__c);
        }
    }
    
    
    
    if(Trigger.isBefore) {
        //ProjectTaskTriggerHelper.validateDate(Trigger.new);
        if(validateProjectTasksList.size() > 0) {
            for(Project_Task__c task : ProjectTaskTriggerHelper.validatePreivous(validateProjectTasksList)) {
                Trigger.newMap.get(task.Id).Completed__c.addError('Cannot complete this task if preivous task is not completed.');
            }
        } 
    }
    
    if(projectIds.size() > 0 && Trigger.isAfter) {
        
        ProjectTaskTriggerHelper.updateStatus = true;
        List<Project__c> projectsUpdateList = ProjectTaskTriggerHelper.updateProjectStatus(projectIds);
        UPDATE projectsUpdateList;
    }
}