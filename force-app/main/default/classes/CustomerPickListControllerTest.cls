@isTest
public class CustomerPickListControllerTest {
    @isTest
    public static void declaringValues() {
        CustomPickListController customPickListController = new CustomPickListController();
    }
    @isTest
    public static void getItems() {
        CustomPickListController customPickListController = new CustomPickListController();
        customPickListController.getItems();
        customPickListController.getState();
        customPickListController.getCity();
        customPickListController.con = 'India';
        customPickListController.country();
        
        customPickListController.con = 'England';
        customPickListController.country();
        
        customPickListController.con = 'Australia';
        customPickListController.country();
        
        customPickListController.con = 'None';
        customPickListController.country();
        
        System.assertEquals('None', customPickListController.con, customPickListController.con);
    }
    @isTest
    public static void stateWorking() {
        CustomPickListController customPickListController = new CustomPickListController();
        
        customPickListController.sta = 'Rajasthan';
        customPickListController.state();
        
        customPickListController.sta = 'Madhyapradesh';
        customPickListController.state();
        
        customPickListController.sta = 'Uttarpradesh';
        customPickListController.state();
        
        customPickListController.sta = 'Scottland';
        customPickListController.state();
        
        customPickListController.sta = 'Wales';
        customPickListController.state();
        
        customPickListController.sta = 'Midlands';
        customPickListController.state();
        
        customPickListController.sta = 'Victoria';
        customPickListController.state();
        
        customPickListController.sta = 'Tasmania';
        customPickListController.state();
        
        customPickListController.sta = 'Queensland';
        customPickListController.state();
        
        customPickListController.sta = '';
        customPickListController.state();
        
        customPickListController.cit = 'Ajmer';
        
        System.assertEquals('Ajmer', customPickListController.cit, customPickListController.cit);
    }
}