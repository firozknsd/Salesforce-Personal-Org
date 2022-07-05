trigger ShowStatusCountAccountTrigger on Account (before insert, after insert, after update) {
    List<Account> accountList = new List<Account>();
    List<Contact> contactList = new List<Contact>();
    List<Opportunity> opportunityList = new List<Opportunity>();
    Account account;
    for(Account tempAcc : Trigger.new) {
        account = tempAcc;
    }
    accountList = [SELECT Id, Rating, Email__c, Phone FROM Account WHERE Rating =: account.Rating ];
    
    if(Trigger.isBefore) {
        for(Account account : Trigger.new) {
            if(account.Rating=='Hot') {
                account.Total_Hot__c = accountList.size()+1;  
            } else if(account.Rating=='Cold') {
                account.Total_Cold__c = accountList.size()+1;
            } else if(account.Rating=='Warm') {
                account.Total_Warm__c = accountList.size()+1;
            }
        }
    }
    if(Trigger.isAfter) {
        Contact contact = new Contact(FirstName = account.Name, LastName = account.Name, Email = account.Email__c, Phone = account.Phone, AccountId = account.Id, Designation__c = 'Clerk',Salary__c=5500);
        contactList.add(contact);
        if(contactList.size() > 0){
            insert contactList;
        }
        date closeDateVal = date.today()+3;
        Opportunity opportunity = new Opportunity(Name = account.Name, AccountId = account.Id, StageName = 'Qualification', CloseDate = closeDateVal, Amount=5000);
        opportunityList.add(opportunity);
        if(opportunityList.size() > 0){
            insert opportunityList;
        }
    }
}