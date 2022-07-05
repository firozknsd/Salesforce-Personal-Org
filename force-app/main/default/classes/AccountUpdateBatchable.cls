global class AccountUpdateBatchable implements Database.Batchable<sObject> {
    Integer count = 6;
    global Database.QueryLocator start(Database.BatchableContext bC) {
        return Database.getQueryLocator([SELECT Id, Name, AccountNumber, Phone, Rating FROM Account WHERE Rating = '']);
    }
    global void execute(Database.BatchableContext bC, List<Account> recordList) {
        for(Account account : recordList) {
            account.Rating = 'Hot';
            account.Phone = '7737608055';
            account.AccountNumber = '12345'+count++;
        }
        update recordList;
    }
    global void finish(Database.BatchableContext bC) {
        System.debug('Chunk size : '+(count-6));
    }
}