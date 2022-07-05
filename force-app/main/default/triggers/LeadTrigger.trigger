trigger LeadTrigger on Lead (before insert, before update) {
    if(Trigger.isInsert || Trigger.isUpdate) {
     	PostalCopyInSICLeadTriggerHelper.postalCopyIntoSIC(trigger.new);   
    }
}