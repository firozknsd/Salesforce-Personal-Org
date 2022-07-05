public class AllAccountController {
    public List<Account> accountList;
    public AllAccountController() {
        accountList = [SELECT Id, Name, Phone, Type From Account];
    }
}