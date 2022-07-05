@isTest
public class CustomerControllerTest {
    @isTest
    public static void customerList() {
        
    	CustomerController customerController = new CustomerController();
        customerController.customer = new Customer__c(First_Name__c='Agwan',Gender__c='Male');
    	Test.startTest();
        //save method
        customerController.save();
        Test.stopTest();
        
        
        customerController.customerList = [SELECT Id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, 
                        Email__c, Phone__c, Nationality__c, Ismarried__c FROM Customer__c];
        
        CustomerController customerController2 = new CustomerController();
        customerController2.customer = new Customer__c(First_Name__c='Customer 2',Gender__c='Male');
        //save & New method
        customerController2.saveAndNew();
        
        //cancel method
        customerController2.cancel();
        
    }
    @isTest
    public static void deleteRecord() {
        
        CustomerController customerController3 = new CustomerController();
        Customer__c customer = new Customer__c(First_Name__c='Sharukh',Gender__c='Male');
    	
        Test.startTest();
        insert customer;
        Test.stopTest();
                
        ApexPages.currentPage().getParameters().put('id',customer.Id);
        customerController3.deleteCustomer();
    }
    @isTest
    public static void editCustomer() {
        
        Customer__c customer4 = new Customer__c(First_Name__c='Salman',Gender__c='Male');
        ApexPages.currentPage().getParameters().put('id',customer4.Id);
        CustomerController customerController4 = new CustomerController();
        
        Test.startTest();
        insert customer4;
        Test.stopTest();
        
        
        customerController4.editCustomer();
        
    }
    @isTest
    public static void viewCustomer() {
        
        Customer__c customer5 = new Customer__c(First_Name__c='Amir',Gender__c='Male');
        ApexPages.currentPage().getParameters().put('viewId',customer5.Id);
        CustomerController customerController5 = new CustomerController();
        
        Test.startTest();
        insert customer5;
        Test.stopTest();
        
        customerController5.viewCustomer();
    }
    @isTest
    public static void cloneCustomer() {
        
        Customer__c customer6 = new Customer__c(First_Name__c='Akshay',Gender__c='Male');
        ApexPages.currentPage().getParameters().put('cloneId',customer6.Id);
        CustomerController customerController6 = new CustomerController();
        
        Test.startTest();
        insert customer6;
        Test.stopTest();
        
        customerController6.cloneCustomer();
    }
    @isTest
    public static void newButton() {
        ApexPages.currentPage().getParameters().put('button','new');
        CustomerController customerController7 = new CustomerController();
        customerController7.newButton();
    }
}