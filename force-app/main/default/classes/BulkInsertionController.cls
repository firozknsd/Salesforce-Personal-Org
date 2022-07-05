public class BulkInsertionController {
    public Contact contact {get;set;}
    public Integer index = 0; 
    public List<Contact> contactList{get;set;}
    public BulkInsertionController() {
        contactList = new List<Contact>();
        contactList.add(new contact());
        contactList.add(new contact());
    }
    public void onInsert() {   
        for(Contact con : contactList) {
            if(!String.isBlank(con.LastName)) {
                insert con;
            }
        }
        
    }
        
}