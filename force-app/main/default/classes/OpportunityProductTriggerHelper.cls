public class OpportunityProductTriggerHelper {
    
    public void onInsert(List<Opportunity_Product__c> currentProduct) {
        List<Opportunity_Product__c> opportunityProductList = [SELECT Id, Opportunity__c, Name, Primary_Product__c 
                                                               FROM Opportunity_Product__c];
        for(Opportunity_Product__c oppo : currentProduct) {
            Integer counter=0;
            for(Opportunity_Product__c allRecordList : opportunityProductList) {
                if(oppo.Primary_Product__c && oppo.Opportunity__c==allRecordList.Opportunity__c) {    
                    allRecordList.Primary_Product__c = false;
                }
                if(oppo.Opportunity__c==allRecordList.Opportunity__c) {
                    counter++;
                }
            }
            if(counter==0) {
                oppo.Primary_Product__c=true;
            }
        }
        update opportunityProductList;
    }
    public void onUpdate(List<Opportunity_Product__c> currentProduct) {
        List<Opportunity_Product__c> opportunityProductList = [SELECT Id, Opportunity__c, Name, Primary_Product__c 
                                                               FROM Opportunity_Product__c];
        List<Opportunity_Product__c> tempList = new List<Opportunity_Product__c>();
        
        for(Opportunity_Product__c oppo : currentProduct) {
            String str = oppo.Opportunity__c;
            Id tempId = oppo.id;
            if(oppo.Primary_Product__c==true) {
                for(Opportunity_Product__c allRecordList : opportunityProductList) {
                    if(allRecordList.id !=  tempId) {
                        if(allRecordList.Opportunity__c == str && allRecordList.Primary_Product__c == true) {
                            allRecordList.Primary_Product__c = false;
                            tempList.add(allRecordList);   
                        }
                    }
                }
            }
        }
        for(Opportunity_Product__c col : tempList) {
            System.debug(col.Name);
        }
        update tempList;
    }
}