trigger ContactTrigger on Contact (before insert, After insert,After update) {
    if(trigger.isUpdate) {
    	ContactStatusUpdateHelper.accountStatusUpdate(trigger.new, trigger.oldMap);
        AssignContactVendorIdToAccount.assignVendorId(trigger.new);
        ContactCountShowInAccount.countContact(trigger.new);
    }
    if(trigger.isInsert) {
        AssignContactVendorIdToAccount.assignVendorId(trigger.new);
        if(trigger.isAfter) {
         	ContactCountShowInAccount.countContact(trigger.new);   
        }
    }
}