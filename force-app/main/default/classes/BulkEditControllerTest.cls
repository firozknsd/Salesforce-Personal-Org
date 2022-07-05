@isTest
public class BulkEditControllerTest {
    @isTest
    public static void bulkEdit() {
        Contact con1 = new Contact(LastName = 'Khan',Designation__c = 'Clerk', Salary__c=5500);
        insert con1;
        BulkEditController bulkEditController = new BulkEditController();
        bulkEditController.contactList.add(con1);
        
        bulkEditController.onInsert();
        
        System.assertEquals(2, bulkEditController.contactList.size());
    }
}