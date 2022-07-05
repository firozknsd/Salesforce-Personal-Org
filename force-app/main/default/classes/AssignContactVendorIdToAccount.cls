public class AssignContactVendorIdToAccount {
    public static void assignVendorId(List<Contact> contactList) {
        Map<id,String> contactIdMap = new Map<id,String>();
        for(Contact contact : contactList) {
            if(contact.vendor_id__c != NULL && contact.accountId != NULL) {
                contactIdMap.put(contact.AccountId, contact.vendor_id__c);
            }
        }
        List<Account> accountList = new List<Account>();
        for(Account account : [SELECT Id, name ,vendor_id__c FROM Account WHERE Id IN : contactIdMap.keySet()]) {
            account.vendor_id__c = contactIdMap.get(account.id);
            accountList.add(account);
        }
        if(accountList.size() > 0) {
            update accountList;
        }
    }
}