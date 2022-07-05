@isTest
public class AllAccountControllerTest {
    @isTest
    public static void accountList() {
        Account account = new Account(Name='Ambuja Cement',AccountNumber='1234567890');
        Test.startTest();
        insert account;
        Test.stopTest();
        
        AllAccountController allAccountController = new AllAccountController();
        System.assertEquals(1, allAccountController.accountList.size());
    }
}