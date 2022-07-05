public class ContactCustomMailController {
    public Contact contact {get;set;}
    public String to{get;set;}
    public String cc{get;set;}
    public String bcc{get;set;}
    public String subject{get;set;}
    public String body{get;set;}
    public Boolean check{get;set;}
    public Boolean htmlBody{get;set;}
    
    public ContactCustomMailController() {
       
    }
    public void onHtmlBodyActive() {
        
    }
    public void onSendMail() {
        try{
            
            String [] ccAddresses = cc.split(',');
            String [] bccAddresses = bcc.split(',');
            
            if(to != NULL) {
                
                String [] toAddresses = to.split(',');
                
                Messaging.SingleEmailMessage emailObject = new Messaging.SingleEmailMessage();
                emailObject.setToAddresses(toAddresses);
                emailObject.setSubject(subject);
                
                if(check == true) {
                    emailObject.setHtmlBody(body); 
                } else {
                    emailObject.setPlainTextBody(body);
                }
                
                if(ccAddresses != NULL) {
                    emailObject.setCcAddresses(ccAddresses);
                }
                if(bccAddresses != NULL) {
                    emailObject.setBccAddresses(bccAddresses);
                }
                
                List<Messaging.Email> emailList = new List<Messaging.Email>();
                emailList.add(emailObject);
                
                Messaging.sendEmail(emailList);
                
            } else {
                ApexPages.addMessage(new ApexPages.message(Apexpages.Severity.INFO,'To Reqiured'));
            }
        } catch(DMLException e) {
            e.getMessage();
        }
    }
}