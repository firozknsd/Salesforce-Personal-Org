trigger StudentEmailRequiredTrigger on Student__c (before insert , after update) {
    for(Student__c student : Trigger.new) {
        if(Trigger.isInsert || Trigger.isUpdate) {
            if(student.Email__c.equals('')) {
                student.Email__c.addError('Email Must Be Required');
            }
        }
        
    }
}