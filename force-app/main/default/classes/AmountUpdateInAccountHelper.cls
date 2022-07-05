public class AmountUpdateInAccountHelper {
    public static void amountUpdate(List<Opportunity> opportunityList) {
        Map<id, Decimal> opportunityMap = new Map<Id, Decimal>();
        for(Opportunity oppo : opportunityList) {
            if(oppo.StageName == 'Closed Won' && oppo.AccountId != NULL) {
                opportunityMap.put(oppo.AccountId, oppo.Amount);
            }
        }
        List<Account> accountList = new List<Account>();
        
        for(Account account : [SELECT Id, Amount__c FROM Account WHERE Id IN : opportunityMap.keySet()]) {
            account.amount__c = opportunityMap.get(account.id);
            accountList.add(account);
        }
        if(accountList.size() > 0) {
            update accountList;
        }
    }
}