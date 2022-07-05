public class EditListBySecondListController {
  public List<Account> accountList{get;set;}
  public Boolean masterCheck{get;set;}
  public List<Account> selectedAccountList{get;set;}
  public List<EditControllerWrapper> accountWithData{get;set;}
  public EditListBySecondListController() {
      accountList = new List<Account>();
      accountList = [SELECT Id, Name, Email__c, Phone, AccountNumber FROM Account LIMIT 10];
      fillValue();
  }
  public void fillValue() {
      accountWithData = new  List<EditControllerWrapper>();
     
      for(Account account : accountList) {
          EditControllerWrapper wrapper = new EditControllerWrapper();
          wrapper.account = account;
          wrapper.isChecked = masterCheck;
          accountWithData.add(wrapper);
      }
  }
 
  public void mannualCheck() {
      Integer check = 0;
      for(EditControllerWrapper accTemp : accountWithData) {
          if(accTemp.isChecked) {
              check++;
          }
      }
      if(check==accountWithData.size()) {
          masterCheck = true;
      } else {
          masterCheck = false;
      }
  }
  public class EditControllerWrapper {
      public Account account{get;set;}
      public Boolean isChecked{get;set;}
  }
   public void getSelectedRecord(){
       selectedAccountList = new List<Account>();
       for(EditControllerWrapper accountListWrapper : accountWithData){
           if(accountListWrapper.isChecked){
               selectedAccountList.add(accountListWrapper.account);
           }
       }
   }
   public void getUpdateRecord() {
       for(EditControllerWrapper acc : accountWithData) {
           update acc.account;
       }
   }
}