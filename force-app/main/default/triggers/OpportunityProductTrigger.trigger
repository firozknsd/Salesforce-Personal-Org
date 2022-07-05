trigger OpportunityProductTrigger on Opportunity_Product__c (before insert, after update) {
    
    List<Opportunity_Product__c> currentProduct = Trigger.new;
    
    /*Opportunity_Product__c currentProduct;
    for(Opportunity_Product__c oppProduct : Trigger.new) {
        currentProduct = oppProduct;
    }
    List<Opportunity_Product__c> opportunityProductList = [SELECT Id, Opportunity__c, Name, Primary_Product__c 
                                                           FROM Opportunity_Product__c 
                                                           WHERE Opportunity__c =: currentProduct.Opportunity__c];
  	*/
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
           	OpportunityProductTriggerHelper obj = new OpportunityProductTriggerHelper();
            obj.onInsert(currentProduct);
        }
    }
    if(Trigger.isAfter) {
        if(Trigger.isUpdate) {
           	OpportunityProductTriggerHelper obj = new OpportunityProductTriggerHelper();
            obj.onUpdate(currentProduct);
        }
    }
}