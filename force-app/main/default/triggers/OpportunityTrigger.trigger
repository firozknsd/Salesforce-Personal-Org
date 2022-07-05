trigger OpportunityTrigger on Opportunity (After insert, After update) {
    if(trigger.isInsert && trigger.isAfter) {
    	AmountUpdateInAccountHelper.amountUpdate(trigger.new);    
    }
}