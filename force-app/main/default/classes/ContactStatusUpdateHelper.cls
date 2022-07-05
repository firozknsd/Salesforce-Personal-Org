public class ContactStatusUpdateHelper {
    public static void accountStatusUpdate(List<Contact> contactList, Map<Id, Contact> contactMap) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact contact : contactList) {
            if(contact.status__c == 'Completed' && contact.accountId != NULL) {
                accountIds.add(contact.accountId);
            }
        }
        List<Account> accountList = new List<Account>();
        List<Account> accountTempList = [SELECT Id, Name, status__c FROM Account WHERE Id IN : accountIds];
        for(Account account : accountTempList) {
            account.status__c = 'Completed';
            accountList.add(account);
        }
        if(accountList.size() > 0) {
            Update accountList;
        }
    }
}