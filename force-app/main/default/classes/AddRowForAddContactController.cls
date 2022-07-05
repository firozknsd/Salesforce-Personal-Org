public class AddRowForAddContactController {
    public List<Contact> contactList{get;set;}
    
    public PageReference pg;
    public AddRowForAddContactController() {
        contactList = new List<Contact>();
        contactList.add(new Contact());
    }
    public PageReference addRow() {
        contactList.add(new Contact());
        return NULL;
    }
    public PageReference onInsert() {
        for(Contact con : contactList) {
            if(!String.isBlank(con.LastName)) {
                Insert con;
            }
        }
        pg = new PageReference('/003/o');
        return pg;
    }
    public PageReference onCancel() {
        pg = new PageReference('/003');
        return pg;
    }
}