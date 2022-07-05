public class SearchByAllFieldController {
    public List<Student__c> studentList {get;set;}
    public Student__c student{get;set;}
    
    public String query;
    public PageReference pg;
    public String name {get;set;}
    public String email {get;set;}
    public String gender {get;set;}
    public Date dob;
    
    public SearchByAllFieldController() {
        student = new Student__c();
        studentList = [SELECT Name, Email__c, Gender__c, Date_Of_Birth__c FROM Student__c];
    }
    public PageReference searchRecord() {
        
        query = 'SELECT Name, Email__c, Gender__c, Date_Of_Birth__c FROM Student__c WHERE ';
        
        if(name != NULL) {
            query += ' Name LIKE \'%' + name + '%\''; 
        }
        
        if(email != NULL && name == NULL ) {
            query += 'Email__c LIKE \'%'+ email + '%\'';
        } else {
            query += ' AND Email__c LIKE \'%'+ email + '%\'';
        }
        
        if(gender != NULL && name == NULL && email == NULL) {
           query += ' Gender__c = \''+ gender + '\'';
        } else if(gender != NULL && name != NULL || email != NULL) {
            query += ' AND Gender__c = \''+ gender + '\'';
        }
        
        /*if(dob != NULL && name == NULL && email == NULL && gender == NULL) {
           query += ' Date_Of_Birth__c =: dob' ;
        } else if(gender != NULL && name != NULL || email != NULL) {
            query += ' AND Gender__c = \''+ gender + '\'';
        }*/
        
        //	String 
        System.debug(query);
        
        //b = student.Date_Of_Birth__c;
        //query = 'SELECT Name, Email__c, Gender__c, Date_Of_Birth__c FROM Student__c WHERE Date_Of_Birth__c =:  dob';
        
        studentList = Database.query(query);
        
        pg = new PageReference('/apex/search_by_all_field');
        return pg;
    }
}