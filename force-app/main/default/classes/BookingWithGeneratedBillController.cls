public class BookingWithGeneratedBillController {
    public Booking__c booking{get;set;}
    public String name{get;set;}
    public Boolean check{get;set;}
    public PageReference pg;
    public String roomNo{get;set;}
    
    public Double price{get;set;}
    public Integer days{get;set;}
    public Double totalAmount{get;set;}
    public String flag{get;set;}
        
    public BookingWithGeneratedBillController() {
        check = false;
        if(flag != NULL) {
            booking = [SELECT Id, Customer__c,room_No__c, Email__c, Status__c, Check_In__c ,Check_Out_Time__c from booking__c limit 1];
        } else {
        	booking = new Booking__c();
        }
    }
    public void addRecords() {
        Customer__c tempCustomer = [SELECT First_Name__c FROM Customer__c WHERE id =: booking.Customer__c ];
        name = tempCustomer.First_Name__c;
        
        Room__c tempRoom = [SELECT Room_No__c, Price__c FROM Room__c WHERE id =: booking.Room_No__c ];
        roomNo = tempRoom.Room_No__c;
        price = tempRoom.Price__c;
        if(booking.Check_Out_Time__c != NULL) {
        	days = (Date.valueOf(booking.Check_In__c)).daysBetween(Date.valueOf(booking.Check_Out_Time__c))+1;    
            totalAmount=days*price;
        }   
        upsert booking;
    }
    public PageReference downloadPDF() { 
       flag = 'true';
       return new PageReference('/apex/text?booking='+booking);
    }
}