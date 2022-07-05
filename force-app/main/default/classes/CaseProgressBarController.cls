public with sharing class CaseProgressBarController {
    @AuraEnabled(cacheable = true)
    public static List<String> getStatusPicklistValues() {
        List<String> statusPicklistValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Case.Status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple) {
            statusPicklistValuesList.add(pickListVal.getLabel());
        }
        return statusPicklistValuesList;
    }
    
    @AuraEnabled(cacheable = true)
    public static Case findCaseStatus(String caseId) {
        Case currentCase = [SELECT Id, Status FROM Case WHERE id =: caseId];
        //System.debug('KKKKKKKKKKKK :'+currentCase.Status);
        return currentCase;
    }
}