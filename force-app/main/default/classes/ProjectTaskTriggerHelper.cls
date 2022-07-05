public class ProjectTaskTriggerHelper {
    
    public static Boolean updateStatus = false;
    public static String currentTask;
    
    //This method is create for update project status.
    public static List<Project__c> updateProjectStatus(Set<Id> projectIds) {
        Map<Id, Project__c> updateProjectMap = new Map<Id, Project__c>();
        String[] projectStatus = new String[] {'', 'New', 'Planning', 'Construction', 'Deployment', 'Signoff'};
        String[] projectTaskType = new String[] {'', 'New Task', 'Planning Phase', 'Construction Work', 'Completion Step', 'Contract End'};
                List <Project_Task__c> taskList = [SELECT Id, Name, Completed__c, Project__c, Type__c, Completion_Date__c,
                                                   (SELECT Id, Name FROM Attachments), 
												   (SELECT Id, Title FROM Notes)
                                                   From Project_Task__c 
                                                   WHERE Completed__c = true
                                                   		AND Project__c IN : projectIds ORDER BY Name];
                
        for(Id projectId : projectIds) {
            updateProjectMap.put(projectId, new Project__c( Id = projectId, Status__c = ''));	    
        }
        if(taskList.size() > 0) {
            for(Project_Task__c task : taskList) {
                if(taskList.get(0).Project__c != task.Project__c) {
                    taskList.get(0).Project__c = task.Project__c;
                }
                updateProjectMap.get(taskList.get(0).Project__c).Status__c = projectStatus.get(projectTaskType.indexOf(task.Type__c));  
            }    
        }
        return updateProjectMap.values();
    }
    
	//Validating previous tasks.    
    public static List<Project_Task__c> validatePreivous(List<Project_Task__c> projectTaskList) {
        Set<Id> projectTaskIdSet = new Set<Id>();
        for(Project_Task__c task : projectTaskList) {
            projectTaskIdSet.add(task.Id);
        }
        List<Project_Task__c> notCompletedProjectTaskList = [SELECT Id, Previous_Task__r.Completed__c, Type__c
                                                             FROM Project_Task__c
                                                             WHERE  Id in : projectTaskIdSet
                                                             		AND Previous_Task__c NOT IN : projectTaskIdSet
                                                             		AND Type__c  != 'New Task'
                                                             		AND Previous_Task__r.Completed__c = false];
        return notCompletedProjectTaskList;
    } 
    /*
    //Validating next tasks.
    public static List<Project_Task__c> validateNext(List<Project_Task__c> projectTaskList) {
        Set<Id> projectTaskSet = new Set<Id>();
        for(Project_Task__c task : projectTaskList) {
            projectTaskSet.add(task.Id);
        }
        
        List<Project_Task__c> failedProjectTaskList = [SELECT Id, Previous_Task__c 
                                                       FROM Project_Task__c
                                                       WHERE Previous_Task__c in : projectTaskSet
                                                       		AND Id NOT in : projectTaskSet
                                                       		AND Completed__c = True];
        return failedProjectTaskList;
    }*/
    /*
    //Validating date field.
    public static void validateDate(List<Project_Task__c> projectTaskList) {
        for(Project_Task__c projectTask : projectTaskList) {
            if(projectTask.Completion_Date__c == NULL && ProjectTask.Completed__c == true) {
                projectTask.Completion_Date__c.addError('Date is required when task is completed.');
            } else if(projectTask.Completion_Date__c != NULL &&  projectTask.Completed__c == false) {
                projectTask.Completed__c.addError('Checked completed if task is completed.');
            }
        }
    }*/
}