@isTest
public class StudentNameSearchControllerTest {
    @isTest
    public static void studentList() {
        
        StudentNameSearchController studentSearch = new StudentNameSearchController();
        Student__c student = new Student__c(Name = 'Khan',Date_Of_Birth__c = date.parse('22/04/1996') ,Email__c='khan@gmail.com');
        Test.startTest();
        insert student;
        Test.stopTest();
        studentSearch.name = 'Khan';
    	studentSearch.searchRecord();
		
        System.assertEquals(1, studentSearch.studentList.size(), studentSearch.name);
    }
}