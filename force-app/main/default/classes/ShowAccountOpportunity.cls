public class ShowAccountOpportunity {
    public ShowAccountOpportunity() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Account> accountList() {
        return [SELECT Id, Name From Account];
    }
    @AuraEnabled
    public static List<Opportunity> opportunityForShow(Id accountId) {
        String query = 'SELECT Name, StageName, CloseDate, Amount FROM Opportunity WHERE AccountId =\'' +accountId+'\'';          
        return Database.query(query);
    }
    @AuraEnabled
    public static String saveOpportunity(Opportunity opportunity) {
        insert opportunity;
        if(opportunity.Id != NULL) {
            return 'Successfull';
        } else {
            return 'Not Inserted !!';
        }
        
    }
    /*
    @AuraEnabled
    public static String saveOpportunity(Id accountId, String name, String stageName, Date closeDate, Integer amount) {
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = name;
        opportunity.StageName = stageName;
        opportunity.CloseDate = closeDate;
        opportunity.Amount = amount;
        opportunity.accountId = accountId;
        insert opportunity;
        
        if(opportunity.Id != NULL) {
            return 'Successfull';
        } else {
            return 'Not Inserted !!';
        }
        
    }*/
}