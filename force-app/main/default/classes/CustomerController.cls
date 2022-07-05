public class CustomerController {
    public List<Customer__c> customerList {get;set;}
    public Id customerId {get;set;}
    public Customer__c customer{get;set;}
    PageReference  pr;
    
    public Boolean edit{get;set;}
    public Id editId{get;set;}
    public Id viewId{get;set;}
    public ID cloneId{get;set;}
    
    public String buttonChecker;
    public Boolean check{get;set;}
    
    public CustomerController() {        
        customerId = ApexPages.currentPage().getParameters().get('id');
        viewId = ApexPages.currentPage().getParameters().get('viewId');
        cloneId = ApexPages.currentPage().getParameters().get('cloneId');
        
        buttonChecker = ApexPages.currentPage().getParameters().get('button');
		
        if(buttonChecker == 'new') {
            check = true;
        }
        
        customerList = [SELECT id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, 
                        Email__c, Phone__c, Nationality__c, Ismarried__c FROM Customer__c ];
        if(customerId != NULL) {
            edit = true;
            customer = [SELECT id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c,
                        Phone__c, Nationality__c, Ismarried__c FROM Customer__c WHERE id =: customerId];
        } else if (viewId != NULL) {
            edit = false;
            customer = [SELECT id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c,
                        Phone__c, Nationality__c, Ismarried__c FROM Customer__c WHERE id =: viewId];
        } else if (cloneId != NULL) {
            edit = true;
            customer = [SELECT id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c,
                        Phone__c, Nationality__c, Ismarried__c FROM Customer__c WHERE id =: cloneId];
            customer.id = null;
            cloneId = null;
        } else {
            edit = true;
        	customer = new Customer__c();
        }  
    }
    
    public PageReference save() {
        upsert customer;
        pr = new pagereference('/apex/all_customers');
        pr.setRedirect(true);
        return pr;
    }
    public PageReference saveAndNew() {
        upsert customer;
        pr = new pagereference('/apex/new_customer');
        pr.setRedirect(true);
        return pr;
    }
    public PageReference cancel() {
         pr = new pagereference('/apex/all_customers');
         return pr;
    }
    public PageReference deleteCustomer() {
        
        customer = [SELECT id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c,Phone__c, Nationality__c, Ismarried__c
        	FROM Customer__c 
        	WHERE id =: customerId];
        
        Delete customer;
       	//DELETE new Customer__c(Id = customerId);
        pr = new pagereference('/apex/all_customers?');
        pr.setRedirect(true);
        return pr;
    }
    public PageReference editCustomer() {
        pr = new pagereference('/apex/new_customer?id='+customerId);
        pr.setRedirect(true);
        return pr;
	}
    public PageReference viewCustomer() {
        pr = new pagereference('/apex/new_customer?viewId='+viewId);
        pr.setRedirect(true);
        return pr;
	}
    public PageReference cloneCustomer() {
        pr = new pagereference('/apex/new_customer?cloneId='+cloneId);
        pr.setRedirect(true);
        return pr;
	}
    public PageReference newButton() {
        pr = new pagereference('/apex/new_customer?button=new');
        pr.setRedirect(true);
        return pr;
	}
}