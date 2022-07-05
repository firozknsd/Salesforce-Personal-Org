public class ContactCustomMailWithListController {
    public Contact contact {get;set;}
    public String to{get;set;}
    public String subject{get;set;}
    public String body{get;set;}
    public Boolean check{get;set;}
    public Boolean masterCheck{get;set;}
    Messaging.EmailFileAttachment emailFileAttachment;
    
    Set<Attachment> attachment;
    
    public Map<Id,String> emailMap = new Map<Id,String>();
    
    public List<Contact> contactList{get;set;}
    public List<ContactCustomMailWithListWrapper> wrapperListData{get;set;}
    
    public ContactCustomMailWithListController() {
        to = '';
        contactList = new List<Contact>();
        emailMap = new Map<Id,String>();
        contactList = [SELECT Id, Name, LastName, Email, Phone FROM Contact];
        fillValue();
        attachment = new Set<Attachment>();
    }
    public void fillValue() {
        wrapperListData = new List<ContactCustomMailWithListWrapper>();
        for(Contact contact : contactList) {
            ContactCustomMailWithListWrapper wrapper = new ContactCustomMailWithListWrapper();
            wrapper.contact = contact;
            wrapper.isChecked = masterCheck;
            wrapperListData.add(wrapper);
        }
    }
    public void onIsChecked() {
      	to = ' ';
        emailMap = new Map<Id,String>();
        for(ContactCustomMailWithListWrapper wrapper : wrapperListData) {
            if(wrapper.isChecked) {
                to += wrapper.contact.Email+',';
                emailMap.put(wrapper.contact.Id,wrapper.contact.Email);
            }
        }
    }
    public void onHtmlBodyActive() {
        
    }
    public void onSendMail() {
        try{	
            for(Attachment att : [SELECT parentId, Name, body, contentType FROM Attachment where parentId =: emailMap.keySet()]){
                Messaging.SingleEmailMessage obj = new Messaging.SingleEmailMessage();
                obj.setToAddresses(new String[]{att.parentId});
                obj.setSubject(subject);
                obj.setPlainTextBody(body); 
                
                if(check) {
                    emailFileAttachment = new Messaging.EmailFileAttachment();
                    emailFileAttachment.setFileName(att.Name);
                    emailFileAttachment.setBody(att.Body);
                    Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[]{emailFileAttachment};
                	obj.setFileAttachments(attachments); 
                }
                	
                Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.Email[]{obj});
                
                if(result[0].success){
                    System.debug('email send successfully');
                } else {
                    System.debug('Error : '+result[0].errors[0].message);
                }
                
            }
        } catch(DMLException e) {
            e.getMessage();
        }
    }
    public void onAddAttachment() {
        
    }
    public class ContactCustomMailWithListWrapper {
        public Boolean isChecked{get;set;}
        public Contact contact{get;set;}
        public ContactCustomMailWithListWrapper() {
       		 
        }
    }
}