public class TemporaryDeleteRowController {
    public List<Contact> contactList{get;set;}
    public Contact contact;
    public Iterator<Integer> iterator;
    public Boolean check;
    PageReference pg;
    public TemporaryDeleteRowController() {
        contactList = new List<Contact>();
        contactList = [SELECT Id, FirstName, LastName, AccountId ,Email FROM Contact];
    }
    
    public PageReference addRow() {
        contactList.add(new Contact());
        return NULL;
    }
    
    public PageReference onInsert() {
        for(Contact con : contactList) {
            if(!String.isBlank(con.LastName)) {
                Upsert con;
            }  
        }
        
        if(contact.id != NULL) {
        	delete contact;   
        }
        return NULL;
    }
    
    public PageReference onDelete() {
        contact = contactList.remove(contactList.size()-1);
        pg = new PageReference('/apex/temporary_delete_row');
        return NULL;
    }
    
    public PageReference onCancel() {
        pg = new PageReference('/apex/temporary_delete_row');
        return NULL;
    }
}