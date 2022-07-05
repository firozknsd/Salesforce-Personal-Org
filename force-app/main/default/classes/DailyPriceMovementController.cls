public with sharing class DailyPriceMovementController {
    @AuraEnabled(cacheable = true)
    public static List<DailyPriceMovementWrapper> getDailyPriceLMovement() {
        
        Set<String> commuditiesSet = new Set<String>();
        List<DailyPriceMovementWrapper> dailyPriceMovementWrapperList = new List<DailyPriceMovementWrapper>();
        List<DailyPriceMovement__c> dailyPriceMovementList = [SELECT Id, Commudity__c, Price__c, Date__c FROM DailyPriceMovement__c];
        for(DailyPriceMovement__c dailyPriceMovement : dailyPriceMovementList) {
        	commuditiesSet.add(dailyPriceMovement.Commudity__c);
        }
        for(String commudity : commuditiesSet) {
            Integer i = 0;
            Decimal today;
        	Decimal yesterday;
        	Decimal oneWeekAgo;
       		Decimal monthStarting;
        	Decimal threeMonthsAgo;
            
            DailyPriceMovementWrapper dailyPriceMovementWrapper;
            
            for(DailyPriceMovement__c dailyPriceMovement : dailyPriceMovementList) {
                
                if(commudity == dailyPriceMovement.Commudity__c) {
                    if(dailyPriceMovement.Date__c == date.valueOf('2021-05-04 00:00:00')) {
                        today = dailyPriceMovement.Price__c;
                    } else if(dailyPriceMovement.Date__c == date.valueOf('2021-05-03 00:00:00')) {
                        yesterday = dailyPriceMovement.Price__c;
                    } else if(dailyPriceMovement.Date__c == date.valueOf('2021-04-27 00:00:00')) {
                        oneWeekAgo = dailyPriceMovement.Price__c;
                    } else if(dailyPriceMovement.Date__c == date.valueOf('2021-05-01 00:00:00')) {
                        monthStarting = dailyPriceMovement.Price__c;
                    } else if(dailyPriceMovement.Date__c == date.valueOf('2021-02-03 00:00:00')) {
                        threeMonthsAgo = dailyPriceMovement.Price__c;
                    }
                    i++;
                }
                if(i==5) {
                    dailyPriceMovementWrapper = new dailyPriceMovementWrapper(
                        dailyPriceMovement.Commudity__c, 
                    	today,
                    	yesterday, 
                    	oneWeekAgo, 
                    	monthStarting,
                    	threeMonthsAgo);
                    dailyPriceMovementWrapperList.add(dailyPriceMovementWrapper);
                    i=0;
                }
            }
        }
        return dailyPriceMovementWrapperList;
    }
    public class DailyPriceMovementWrapper {
        @AuraEnabled
        public String commudity;
        @AuraEnabled
        public Decimal today;
        @AuraEnabled
        public Decimal yesterday;
        @AuraEnabled
        public Decimal oneWeekAgo;
        @AuraEnabled
        public Decimal monthStarting;
        @AuraEnabled
        public Decimal threeMonthsAgo;

        public DailyPriceMovementWrapper(
            String commudity,
            Decimal today, 
            Decimal yesterday, 
            Decimal oneWeekAgo,
            Decimal monthStarting,
            Decimal threeMonthsAgo) {

                this.commudity = commudity;
                this.today = today;
                this.yesterday = yesterday;
                this.oneWeekAgo = oneWeekAgo;
                this.monthStarting = monthStarting;
                this.threeMonthsAgo = threeMonthsAgo;
        }
    }
}