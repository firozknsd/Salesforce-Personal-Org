public class DailyWorkStatusController {
    public DailyWorkStatusController() {
        
    }
    public Integer getContact() {
        return [SELECT Id, Name FROM Contact WHERE CreatedDate =: System.today()].size();
    }
    public void sendMail() {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { 'firozknsd@gmail.com' });
        email.setSubject('Show Your Contact Count');
        String body = 'Hi Firoz,<\n>';
        body = 'Your today inserted contacts : '+ getContact();
        email.setPlainTextBody(body);
        
       List<Messaging.SendEmailResult> results = 
            Messaging.sendEmail(new Messaging.Email[] { email });
        if (!results.get(0).isSuccess()) {
            System.StatusCode statusCode = results.get(0).getErrors()[0].getStatusCode();
            String errorMessage = results.get(0).getErrors()[0].getMessage();
        }
    }
}