public class PostalCopyInSICLeadTriggerHelper {
    public static void postalCopyIntoSIC(List<Lead> leadList) {
        for(Lead lead : leadList) {
            if(Trigger.isInsert) {
                if(lead.PostalCode == NULL) {
                    lead.PostalCode.addError('Please input postal code.');
                }
            }
            if(Trigger.isUpdate) {
                if(lead.PostalCode != lead.SICCode__c || lead.PostalCode != NULL || lead.SICCode__c == NULL) {
                    lead.addError('You can\'t update those fields manually.');  
                }
            }
            if(lead.PostalCode != NULL) {
                lead.SICCode__c = lead.PostalCode;       
            }
        }
    }
}