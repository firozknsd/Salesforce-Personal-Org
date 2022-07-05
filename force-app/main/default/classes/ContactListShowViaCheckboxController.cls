public with sharing class ContactListShowViaCheckboxController {
    public ContactListShowViaCheckboxController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactList() {
        return [SELECT Id, Name, Phone, Email FROM Contact LIMIT 10];
    }
}