public class AllSelectAccountWrapperController {
    public List<Account> accountList;
    public Boolean masterCheck{get;set;}
    //public List<Account> selectedAccountList{get;set;}
    public List<AllSelectWrapperControllerWrapper> accountWithData{get;set;}
    public AllSelectAccountWrapperController() {
        accountList = new List<Account>();
        accountList = [SELECT Id, Name, Email__c, Phone, AccountNumber FROM Account LIMIT 10];
        fillValue();
    }
    public void fillValue() {
        accountWithData = new  List<AllSelectWrapperControllerWrapper>();
        
        for(Account account : accountList) {
            AllSelectWrapperControllerWrapper xyz = new AllSelectWrapperControllerWrapper();
            xyz.account = account;
            xyz.isChecked = masterCheck;
            accountWithData.add(xyz);
        }
    }
    public void onIsCheck() {
        if(masterCheck) {
            fillValue();
        } else {
            fillValue();
        }
    }
    public void mannualCheck() {
        masterCheck = true;
        for(AllSelectWrapperControllerWrapper accTemp : accountWithData) {
            if(accTemp.isChecked) {
                 masterCheck = true;
            } else {
                masterCheck = false;
                break;
            }
        }
    }
    
    
    public class AllSelectWrapperControllerWrapper {
        public Account account{get;set;}
        public Boolean isChecked{get;set;}
    }
}