public with sharing class DependentPicklistController {
    public DependentPicklistController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 10];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getWithoutName() {
        return [SELECT Id, Phone, Email FROM Contact LIMIT 10];
    }
}