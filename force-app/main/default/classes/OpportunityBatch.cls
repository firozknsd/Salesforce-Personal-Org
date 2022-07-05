public class OpportunityBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, Name, StageName, CloseDate, Amount FROM Opportunity WHERE Amount !=: NULL]);
    }
    public void execute(Database.BatchableContext BC, List<Opportunity> recordList) {
        Double amt;
        for(Opportunity opportunity : recordList) {
            amt = opportunity.Amount;
            amt = (amt*10)/100;
            opportunity.Amount = opportunity.Amount+amt;
        }
        update recordList;
    }
    public void finish(Database.BatchableContext BC) {
        AsyncApexJob asyncJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CompletedDate, ExtendedStatus, ApexClass.name, CreatedBy.Email, CreatedBy.Name
                          FROM AsyncApexJob 
                          WHERE Id =:BC.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new string[]{'firozknsd@gmail.com'};
        Mail.setToAddresses(toAddress);
        Mail.setSubject('Apex Sharing Recalculation ' + asyncJob.Status);
        
        
        string td1='"padding-top: 12px;padding-bottom: 12px;text-align: left;background-color: #04AA6D;color: white;"';
        string td2='"border: 1px solid #ddd;padding: 8px;"';
        string tdHead='"border:1px solid green; width=200px; color:white; background-color:green; font-weight:bold;"';
      
        string htmlBody = '<div style="border:2px solid grey; border-radius:15px; padding-left: 80px;  padding-right: 30px;"><p>Hi,</p><p><span style="color:brown; font-weight:bolder;">Salesforce</span> completed running <b>Apex Batch Code<></b>.</p>'
            +'<p>Results:</p>'
            +'<hr style="height:1px;border-width:0;gray:yellow;background-color:gray">'
            +'<center><table style="font-family: Arial, Helvetica, sans-serif; border-collapse: collapse;width: 90%;">'
            +'<tr style="background-color: #f2f2f2;"><th style='+td1+'>Class Name</th>'
            +'<th style='+td1+'>Completed Date</th>'
            +'<th style='+td1+'>Status</th>'
            +'<th style='+td1+'>Job Items Processed</th>'
            +'<th style='+td1+'>NumberOfErrors</th>'
            +'<th style='+td1+'>Extended Status</th>'
            +'<th style='+td1+'>Created By</th></tr>'
            +'<tr style="background-color: #f2f2f2;"><td style='+td2+'>'+asyncJob.ApexClass.name+'</td>'
            +'<td style='+td2+'>'+asyncJob.CompletedDate+'</td>'
            +'<td style='+td2+'>'+asyncJob.Status+'</td>'
            +'<td style='+td2+'>'+asyncJob.JobItemsProcessed+' / '+asyncJob.TotalJobItems+'</td>'
            +'<td style='+td2+'>'+asyncJob.NumberOfErrors+'</td>'
            +'<td style='+td2+'>'+asyncJob.ExtendedStatus+'</td>'
            +'<td style='+td2+'>'+asyncJob.CreatedBy.Name+' ('+asyncJob.CreatedBy.Email+')</td></tr>'
            +'</table></center>'
            +'<hr style="height:1px;border-width:0;color:gray;background-color:gray">'
            +'<p>Enjoy the <b style="color:green;">results</b>!</p><p style="color:black;"><span style="font-family:"Courier New", Courier, monospace; font-weight:bold; font-size:larger;">Firoz Khan Agwan</span></p></div>';
        
        	mail.setHtmlBody(htmlBody);
        	Mail.setPlainTextBody('The batch Apex job completed on  ' + asyncJob.CompletedDate + ',\n\n' +
                              'Job Status : ' + asyncJob.Status + '\n'+
                              'Total Job Items processed : ' + asyncJob.TotalJobItems + '\n'+
                              'Number of Job Items processed : ' + asyncJob.JobItemsProcessed + '\n' +
                              'Number of Failures : '+ asyncJob.NumberOfErrors);
        	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           }
}