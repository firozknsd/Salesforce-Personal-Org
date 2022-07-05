public class ProjectTriggerHelper {
    
    //Project tasks create when new project record inserted.
    public static void createProjectTasks(Set <Id> insertedProjectIdSet) {
        String[] projectTaskType = new String[] {'New Task', 'Planning Phase', 'Construction Work', 'Completion Step', 'Contract End'};
        List <Project_Task__c> projectTaskList = new List <Project_Task__c>();
        
        for(Id projectId : insertedProjectIdSet) {
            for(Integer count = 0; count < 5 ; count++) {
                projectTaskList.add(new Project_Task__c (Type__c = projectTaskType[count], Project__c = projectId));
            }
        }
        if(projectTaskList.size() > 0) {
        	insert projectTaskList;   
        }
        
        for(Integer index = 1; index < projectTaskList.size(); index++) {
            if(projectTaskList.get(index).Type__c != 'New Task'){
                projectTaskList.get(index).Previous_Task__c = projectTaskList.get(index - 1).Id;
            }
        }
        if(projectTaskList.size() > 0) {
        	update projectTaskList;   
        }
    }
}