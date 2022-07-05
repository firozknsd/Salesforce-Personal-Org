/*
		Name 		:	SearchContacts
		Date 		:	4th June 2021
		Author 		:	Firoz Khan Agwan
		Description :	This is design for to 
						display contacts, search contact, show records on the basis of dropdown(5,10,..100) 
						and navigate contacts by buttons.
*/
public with sharing class SearchContactsLWCController {
    public SearchContactsLWCController() {

    }

    // This method is responsible to search value and return all data.
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchList(String searchValue) {
        if(searchValue != '' && searchValue != NULL) {
            return [SELECT Id, Name, Email, AccountId, Phone, Type__c FROM Contact 
                    WHERE Name LIKE : '%' + searchValue + '%' 
                        OR Email LIKE : '%' + searchValue + '%'];
        }
        return [SELECT Id, Name, Email, AccountId, Phone, Type__c FROM Contact];
    }
}