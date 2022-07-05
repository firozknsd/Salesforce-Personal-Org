public class RemoveElementFromSecondList {
    public List<Account> accountList;
    public Boolean masterCheck{get;set;}
    public List<RemoveControllerWrapper> selectedAccountList{get;set;}
    public List<RemoveControllerWrapper> accountWithData{get;set;}
    public RemoveElementFromSecondList() {
        accountList = new List<Account>();
        selectedAccountList = new List<RemoveControllerWrapper>();
        accountList = [SELECT Id, Name, Email__c, Phone, AccountNumber FROM Account LIMIT 10];
        fillValue();
    }
    public void fillValue() {
        accountWithData = new  List<RemoveControllerWrapper>();
        for(Account account : accountList) {
            RemoveControllerWrapper wrapper = new RemoveControllerWrapper();
            wrapper.account = account;
            wrapper.isChecked = masterCheck;
            accountWithData.add(wrapper);
        }
    }
    
    public void mannualCheck() {
        Integer check = 0;
        for(RemoveControllerWrapper accTemp : accountWithData) {
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
    
    public void getSelectedRecord() {
        List<Integer> tempList = new List<Integer>();
        Integer counter=0;
        for(RemoveControllerWrapper accountListWrapper : accountWithData) {
            if(accountListWrapper.isChecked) {
                accountListWrapper.isChecked = false;
                selectedAccountList.add(accountListWrapper);
                tempList.add(counter);
                if(masterCheck) {
                    masterCheck = false;
                }
            } 
            counter++;
        }
        Integer index=0;
        for(Integer i : tempList) {
            accountWithData.remove(i-index);
            index++;
        }
    }
    public void removeElement() {
        List<Integer> tempList = new List<Integer>();
        Integer counter=0;
        for(RemoveControllerWrapper acc : selectedAccountList) {
            if(acc.isChecked) {
                acc.isChecked = false;
                accountWithData.add(acc);
                tempList.add(counter);
            }
            counter++;
        }
        Integer index=0;
        for(Integer i : tempList) {
            selectedAccountList.remove(i-index);
            index++;
        }
    }
    public class RemoveControllerWrapper {
        public Account account{get;set;}
        public Boolean isChecked{get;set;}
    }
}