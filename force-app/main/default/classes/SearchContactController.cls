/*
		Name 		:	ContactDetailController
		Date 		:	31st May 2021
		Author 		:	Firoz Khan Agwan
		Description :	This controller is design for to 
						display contacts, search contact, show records on the basis of dropdown(5,10,..100) 
						and navigate contacts by buttons.
*/
public class SearchContactController {
	public List<Contact> contactRecordList;
	public List<Contact> searchRecordList;
	public Integer pageOffset{get;set;}
	public Integer pageNumber{get;set;}
	public String searchValue{get;set;}
	private Integer limitValue;
	private Integer totalRecords;
    public Boolean showOrHide{get;set;}	//Make meanningfull
    
	public SearchContactController() {
		init();
	}
    
    //init method is design for initializing members.
	public void init() {
        contactRecordList = new List<Contact>();
        limitValue = 0;
		searchValue = ''; 
		pageOffset = 5;
		searchContact();
    }
    
    //This method is working on searching and pass searched records.
	public void searchContact() {
		pageNumber = 1;
        searchRecordList = [SELECT Id, Name, Email, Account.Name, Phone, Type__c FROM Contact 
                            WHERE Name LIKE : '%' + searchValue + '%' 
                            	OR Email LIKE : '%' + searchValue + '%'];
        
		totalRecords = searchRecordList.size();
        if(totalRecords <= 0) {
            showOrHide = true;
        } else {
            showOrHide = false;
        }
	}
    
    //This method is create to pass values in dropdown.
	public List<SelectOption> getItems() {
		List<SelectOption> optionList = new List<SelectOption>();
		optionList.add(new SelectOption('5','5'));
		optionList.add(new SelectOption('10','10'));
		optionList.add(new SelectOption('15','15'));
		optionList.add(new SelectOption('20','20'));
		optionList.add(new SelectOption('100','100'));
		return optionList;
	}
    
    //This method is create to pass records in Tables.
	public List<Contact> getContactList() {
		contactRecordList.clear();
		Integer length = totalRecords;
        Integer limitHolder = limitValue + pageOffset;
        if((limitHolder) < totalRecords ) {
            length = limitHolder;
		}
        
		for(Integer index = limitValue; index < length; index++) {
			contactRecordList.add(searchRecordList.get(index));
		}
		return contactRecordList;
    }
    
    //First button working depends on this (first()) method.
	public void first() {
		pageNumber = 1;
		limitValue = 0;
	}
    
    //previous button working depends on this (previous()) method.
	public void previous() {
		if(pageNumber > 1 ) {
            limitValue = 0;
			if((limitValue - pageOffset) > 0 ) {
				limitValue =  limitValue - pageOffset ;  
			} 
			pageNumber--;
		}
	}
    
    //Next button working depends on this (nextButton()) method.
	public void next() {
		pageNumber++;
		limitValue += pageOffset;
	}
    
    //Last button working depends on this (lastButton()) method.
	public void last() {
        pageNumber = (Integer) Math.ceil((double) totalRecords / pageOffset);
		limitValue = pageOffset * (pageNumber - 1);  
	}
    
    //First and Previous buttons disabling and enabling depends on this method.
	public Boolean getDisableFirstPrevious() {
		if(pageNumber == 1) { 
            return true;
		}
		return false;
	}
    
    //Next and Last buttons disabling and enabling depends on this method.
	public Boolean getDisableNextLast() {
		if((pageOffset * pageNumber) < totalRecords) { 
			return false;
		}
		return true;
	}
}