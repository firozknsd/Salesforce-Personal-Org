public class ContactActionFunctionWithAddController {
    public List<Contact> contactList;
    public Boolean checkGlobal{get;set;}
    public Boolean saveButtonCheck{get;set;}
    List<Contact> tempList;
    public List<ContactActionFunctionListControllerWrapper> tempAddList;
    public ContactActionFunctionListControllerWrapper wrapperClass;
    public List<ContactActionFunctionListControllerWrapper> contactListWrapper{get;set;}
    
    public Boolean onAdd{get;set;}
    public Id tempId{get;set;}
    
    public Contact con;
   
    
    public ContactActionFunctionWithAddController() {
        tempList = new List<Contact>();
        contactList = new List<Contact>();
        tempAddList = new List<ContactActionFunctionListControllerWrapper>();
        contactList = [SELECT Id, Name, LastName, Email, Phone FROM CONTACT];
        
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
        saveButtonCheck = true;
    }
    public void onDelete() {
        checkGlobal = false;
        saveButtonCheck = true;
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
        try {
            for(ContactActionFunctionListControllerWrapper check : contactListWrapper) {
                if(check.isChecked) {
                    upsert check.contact;
                    check.isChecked = false;
                    checkGlobal = false;
                    saveButtonCheck = false;
                }
            }
            for(Contact obj : tempList) {
                if(obj.LastName != '') {
                    delete tempList;
                }   
            }
        } catch(DMLException e) {
            e.getMessage();
        }
    }
    public void onAddRow() {
        onAdd = true;
        Contact temp = new Contact();
        Integer index;
        ContactActionFunctionListControllerWrapper wrapperObj = new ContactActionFunctionListControllerWrapper();
        wrapperObj.contact = temp;
        wrapperObj.isChecked = true;
        for(ContactActionFunctionListControllerWrapper obj : contactListWrapper) {
            if(obj.addChecked) {
                index = contactListWrapper.indexOf(obj)+1;
            }
        }
        if(index == contactListWrapper.size()) {
            contactListWrapper.add(wrapperObj);
        } else {
            contactListWrapper.add(index , wrapperObj);    
        }
        tempAddList.add(wrapperObj);
        
        index=0;
        saveButtonCheck = true;
        
        
    }
    public class ContactActionFunctionListControllerWrapper {
        public Contact contact{get;set;}
        public Boolean isChecked{get;set;}
        public Boolean isDelete{get;set;}
        public Boolean addChecked{get;set;}
        
        public ContactActionFunctionListControllerWrapper() {
            isDelete = false;
            addChecked = false;
        }
    }
}