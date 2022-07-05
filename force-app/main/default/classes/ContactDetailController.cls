/*
	Name 		:	ContactDetailController
	Date 		:	31st May 2021
	Author 		:	Firoz Khan Agwan
	Description :	This controller is design for to 
					display contacts, search contact, show records on the basis of dropdown(5,10,..100) 
					and navigate contacts by buttons.
*/
public class ContactDetailController {
    public String searchValue{get;set;}
    List<SelectOption> recordLimit;
    public Integer blockSize{get;set;}
    private Integer totalRecords = 0;
    public Integer counter;
	private Boolean flag = false;  
	private Integer totalSearchRecord;
    
    public Boolean previousButtonStatus {get;set;}
    public Boolean nextButtonStatus {get;set;}
    public Boolean firstButtonStatus {get;set;}
    public Boolean lastButtonStatus {get;set;}
    
    public ContactDetailController() {
        buttonHandling();
        blockSize = 5;
        counter = 0;
        totalRecords = [select count() from contact];
    }
    public List<SelectOption> getItems() {
        recordLimit = new List<SelectOption>();
        recordLimit.add(new SelectOption('5','5'));
        recordLimit.add(new SelectOption('10','10'));
        recordLimit.add(new SelectOption('15','15'));
        recordLimit.add(new SelectOption('20','20'));
        recordLimit.add(new SelectOption('100','100'));
        return recordLimit;
    }
    public void buttonHandling() {
        firstButtonStatus = true;
        previousButtonStatus = true;
        nextButtonStatus = false;
        lastButtonStatus = false;
    }
    public List<Contact> getcontactList() {
        List<contact> contactList = Database.Query('SELECT Id, Name, Email, Account.Name, Phone, Type__c FROM Contact LIMIT :blockSize OFFSET : counter');
        return contactList;
    }
    public List<Contact> getTemp() {
        if(flag) {
            String query;
        	if(searchValue.contains('@') && searchValue.contains('.')) {
            	query = 'SELECT Id, Name, Email, Account.Name, Phone, Type__c FROM Contact WHERE Email LIKE \'%'+ searchValue + '%\' LIMIT :blockSize OFFSET : counter';
        	} else {
            	query = 'SELECT Id, Name, Email, Account.Name, Phone, Type__c FROM Contact WHERE Name LIKE \'%'+ searchValue + '%\' LIMIT :blockSize OFFSET : counter';
            }
            List<Contact> searchRecordList = Database.query(query);
            totalSearchRecord = searchRecordList.size();
            if(totalSearchRecord < blockSize) {
                firstButtonStatus = true;
                nextButtonStatus = true;
                previousButtonStatus = true;
                lastButtonStatus = true;
            } else {
                buttonHandling();
            }
            return searchRecordList;
        } else {
            return getcontactList();   
        }
    }
    public void firstbtn(){
        counter = 0;
        firstButtonStatus = true;
        nextButtonStatus = false;
        previousButtonStatus = true;
        lastButtonStatus = false;
    }
    public void nextbtn(){
        counter += blockSize ;
        firstButtonStatus = false;
        previousButtonStatus = false;
        if(counter==totalRecords - math.mod(totalRecords,blockSize)) {
            nextButtonStatus = true;
            lastButtonStatus = true;
        }
    }
    public void previousbtn(){
        counter -= blockSize;
        if(counter==0) {
            firstButtonStatus = true;
            nextButtonStatus = false;
        	previousButtonStatus = true;
        } else {
            lastButtonStatus = false;
            nextButtonStatus = false;
        }
    }
    public void lastbtn(){
        counter = totalRecords - math.mod(totalRecords,blockSize);
        firstButtonStatus = false;
        nextButtonStatus = true;
        previousButtonStatus = false;
        lastButtonStatus = true;
    }
    public void pageSize(){
        counter = 0;
        if(blockSize == 0){
            blockSize = totalRecords;
        }
    }
    public void searchRecord() {
        flag=true;
        getTemp();
    }
}