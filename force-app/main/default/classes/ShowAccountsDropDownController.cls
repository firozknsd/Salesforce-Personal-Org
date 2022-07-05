public with sharing class ShowAccountsDropDownController {
    public ShowAccountsDropDownController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Account> accountList() {
        return [SELECT Id, Name, AccountNumber, Phone, Fax, BillingState, BillingCity From Account];
    }
    @AuraEnabled
    public static Contact contactForShow(String contactLastName) {
        String query = 'SELECT FirstName, LastName, Email, Phone FROM Contact WHERE LastName =\'' +contactLastName+'\'';          
        return Database.query(query);
    }
    @AuraEnabled
    public static Opportunity opportunityForShow(String opportunityName) {
        String query = 'SELECT Name, StageName, CloseDate, Amount FROM Opportunity WHERE Name =\'' +opportunityName+'\'';          
        return Database.query(query);
    }
}