public class ContactCountShowInAccount {
    public static void countContact(List<Contact> contactList) {
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact contact : contactList) {
            if(contact.AccountId != NULL) {
                accountIdSet.add(contact.AccountId);
            }
        }
        List<Account> accountList = new List<Account>();
        for(Account account : [SELECT Id, Num_Of_Contacts__c,(SELECT Id FROM Contacts) FROM Account WHERE id IN : accountIdSet]) {
        	account.Num_Of_Contacts__c = account.Contacts.size(); 
            accountList.add(account);
        }
        if(accountList.size() > 0) {
            update accountList;
        }
    }
}