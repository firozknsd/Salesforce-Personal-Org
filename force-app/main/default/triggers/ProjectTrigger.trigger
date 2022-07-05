/*
		Name 		:	ProjectCreationTrigger
		Date 		:	08 June 2021
		Author 		:	Firoz Khan Agwan
		Description :	Trigger to validate project.
		Helper		:	ProjectTriggerHelper
*/
trigger ProjectTrigger on Project__c (before insert, after insert, before update) {
	if(Trigger.isInsert && Trigger.isAfter) {
        ProjectTriggerHelper.createProjectTasks(Trigger.newMap.keySet());
    }
    
    if(Trigger.isBefore) {
        for(Project__c project : Trigger.new) {
            if(Trigger.isInsert) {
                if(project.Status__c != NULL) {
                    project.Status__c.addError('Status changes not acceptable.');
                }
            }
            if(ProjectTaskTriggerHelper.updateStatus == false && Trigger.isUpdate) {
                if( project.Status__c != Trigger.oldMap.get(project.Id).Status__c ) {
                    project.Status__c.addError('Status changes not acceptable.');
                }
            }
        }        
    }
    
    /*
    //When user insert status.
    if(Trigger.isInsert && Trigger.isBefore) {
        for(Project__c project : Trigger.new) {
            if(project.Status__c != NULL) {
                project.Status__c.addError('Status not acceptable.');
            }
        }
    }*/
    /*
    //When user update status.
    if(Trigger.isUpdate && Trigger.isBefore) {
        List<String> projactStatus = new List<String>();
        for(Project__c project : Trigger.old) {
            projactStatus.add(project.Status__c);
            System.debug('New Status : '+project.Status__c);
        }
        for(Project__c project : Trigger.new) {
            System.debug('Old Status : '+project.Status__c);
            for(Integer index = 0; index < projactStatus.size(); index++) {
                if(projactStatus.get(index) != project.Status__c) {
                    project.Status__c.addError('You cant update status.');
                }    
            }
        }
    }*/
}