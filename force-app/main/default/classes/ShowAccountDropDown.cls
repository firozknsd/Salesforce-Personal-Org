public with sharing class ShowAccountDropDown {
    public ShowAccountDropDown() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Account> accountList() {
        return [SELECT Id, Name, AccountNumber, Phone, Fax, BillingState, BillingCity From Account];
    }
}