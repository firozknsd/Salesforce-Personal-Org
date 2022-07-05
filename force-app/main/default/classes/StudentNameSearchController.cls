public class StudentNameSearchController {
    public Student__c student{get;set;}
    public PageReference pg;
    public String name {get;set;}
    public List<Student__c> studentList {get;set;}
    
    public StudentNameSearchController() {
        studentList = [SELECT Name, Last_Name__c, Gender__c, Phone__c, Date_Of_Birth__c FROM Student__c];
    }
    public PageReference searchRecord() {
        if(name != Null) {
            studentList = [SELECT Name, Last_Name__c, Gender__c, Phone__c, Date_Of_Birth__c FROM Student__c WHERE Name LIKE : '%'+ name +'%'];
            pg = new PageReference('/apex/search_student');
            return pg;
        } else {
            new StudentNameSearchController();
            return NULL;
        }
    }
}