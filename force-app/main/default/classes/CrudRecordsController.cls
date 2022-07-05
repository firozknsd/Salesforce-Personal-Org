public class CrudRecordsController {
    public CrudRecordsController(){
        
    }
	@AuraEnabled(cacheable=true)
    public static List<Contact> contactList() {
        return [SELECT id, FirstName, LastName, Name, Phone, Email, Designation__c, Salary__c FROM Contact];
    }
    @AuraEnabled
    public static String deleteRecord(Id recordId) {
        String query = 'SELECT id, FirstName, LastName, Name, Phone, Email, Designation__c, Salary__c FROM Contact WHERE Id = \'' + recordId +'\'';
        Contact contact =  Database.query(query);
        Delete contact;
        return 'Deleted Successfully';
    }
    @AuraEnabled
    public static String cloneRecord(Contact contact) {
        Insert contact;
        return 'Clonning Successful';
    }
}