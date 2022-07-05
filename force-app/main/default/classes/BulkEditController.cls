public class BulkEditController {
    //public Contact contact {get;set;}
    //public Integer index = 0; 
    public List<Contact> contactList{get;set;}
    PageReference pg;
    public BulkEditController() {
        contactList = new List<Contact>();
        contactList = [SELECT Id, FirstName, LastName, AccountId FROM Contact];
    }
    public PageReference onInsert() {   
        for(Contact con : contactList) {
            if(!String.isBlank(con.LastName)) {
                Update con;
            }
        }
        pg = new PageReference('/003');
        return pg;
    }
        
}