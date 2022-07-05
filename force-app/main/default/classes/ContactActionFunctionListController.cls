public class ContactActionFunctionListController {
    public List<Contact> contactList;
    public Boolean checkGlobal{get;set;}
    List<Contact> tempList;
    public List<ContactActionFunctionListControllerWrapper> contactListWrapper{get;set;}
    public ContactActionFunctionListController() {
        tempList = new List<Contact>();
        contactList = new List<Contact>();
        contactList = [SELECT Id, Name, LastName, Email, Phone FROM CONTACT limit 10];
        fillValue();
    }
    public void fillValue() {
        contactListWrapper = new  List<ContactActionFunctionListControllerWrapper>();
        for(Contact contact : contactList) {
            ContactActionFunctionListControllerWrapper wrapper = new ContactActionFunctionListControllerWrapper();
            wrapper.contact = contact;
            wrapper.isChecked = checkGlobal;
            contactListWrapper.add(wrapper);
        }
    }
    public void showInputField() {
        Integer check = 0;
        for(ContactActionFunctionListControllerWrapper accTemp : contactListWrapper) {
            if(accTemp.isChecked) {
                check++;
            }
        }
        if(check==contactListWrapper.size()) {
            checkGlobal = true;
        } else {
            checkGlobal = false;
        }
    }
    public void onDelete() {
        checkGlobal = true;
        Integer counter = 0;
        for(ContactActionFunctionListControllerWrapper check : contactListWrapper) {
            if(check.isDelete) {
                tempList.add(check.contact);
                contactListWrapper.remove(counter);
                break;
            }
            counter++;
        }
    }
    public void updateRecord() {
        for(ContactActionFunctionListControllerWrapper check : contactListWrapper) {
            if(check.isChecked) {
                Update check.contact;
                check.isChecked = false;
                checkGlobal = false;
            }
        }
        for(Contact i : tempList) {
            delete i;
        }
        tempList = new List<Contact>();
    }
    public class ContactActionFunctionListControllerWrapper {
        public Contact contact{get;set;}
        public Boolean isChecked{get;set;}
        public Boolean isDelete{get;set;}
        
        public ContactActionFunctionListControllerWrapper() {
            isDelete = false;
        }
    }
}