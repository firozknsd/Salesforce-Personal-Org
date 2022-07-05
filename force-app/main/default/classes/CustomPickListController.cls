public class CustomPickListController {
    public List<String> countries{get;set;}
    public string con{get;set;}
    public string sta{get;set;}
    public string cit{get;set;}
    List<SelectOption> options;
    List<SelectOption> stateOptions;
    List<SelectOption> cityOptions;
    
    public CustomPickListController() {
        countries = new List<String>();
        stateOptions = new List<SelectOption>();
        cityOptions = new List<SelectOption>();
        stateOptions.add(new SelectOption('','-- None --'));
        cityOptions.add(new SelectOption('','-- None --'));
    }
    public List<SelectOption> getItems() {
        options = new List<SelectOption>();
        options.add(new SelectOption('none','-- None --'));
        options.add(new SelectOption('india','India'));
        options.add(new SelectOption('england','England'));
        options.add(new SelectOption('australia','Australia'));
        return options;
    }
    public List<SelectOption> getState() {
        return stateOptions;
    }
    public List<SelectOption> getCity() {
        return cityOptions;
    }
    public void country() {
        if(con == 'India') {
            stateOptions = new List<SelectOption>();
            stateOptions.add(new SelectOption('','-- None --'));
            stateOptions.add(new SelectOption('rajasthan','Rajasthan'));
            stateOptions.add(new SelectOption('madhyapradesh','Madhyapradesh'));
            stateOptions.add(new SelectOption('uttarpradesh','Uttarpradesh'));
            
        } else if(con == 'England') {
            
            stateOptions = new List<SelectOption>();
            stateOptions.add(new SelectOption('','-- None --'));
            stateOptions.add(new SelectOption('scottland','Scottland'));
            stateOptions.add(new SelectOption('wales','Wales'));
            stateOptions.add(new SelectOption('midlands','Midlands'));
            
        } else if(con == 'Australia') {
            
            stateOptions = new List<SelectOption>();
            stateOptions.add(new SelectOption('','-- None --'));
            stateOptions.add(new SelectOption('victoria','Victoria'));
            stateOptions.add(new SelectOption('tasmania','Tasmania'));
            stateOptions.add(new SelectOption('queensland','Queensland'));
            
        } else if(con == 'None') {
            
            stateOptions = new List<SelectOption>();
            stateOptions.add(new SelectOption('none','-- None --'));
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('none','-- None --'));
        }
    }
    public void state() {
        if(sta == 'Rajasthan') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('ajmer','Ajmer'));
            cityOptions.add(new SelectOption('kota','Kota'));
            cityOptions.add(new SelectOption('jaipur','Jaipur'));
        } else if(sta == 'Madhyapradesh') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('indore','Indore'));
            cityOptions.add(new SelectOption('bhopal','Bhopal'));
            cityOptions.add(new SelectOption('jabalpur','Jabalpur'));
        } else if(sta == 'Uttarpradesh') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('agra','Agra'));
            cityOptions.add(new SelectOption('aligarh','aligarh'));
            cityOptions.add(new SelectOption('allahabad','Allahabad'));
        } else if(sta == 'Scottland') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('angus','Angus'));
            cityOptions.add(new SelectOption('argyll','Argyll'));
            cityOptions.add(new SelectOption('ayrshire','Ayrshire'));
        } else if(sta == 'Wales') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('carmarthen','Carmarthen'));
            cityOptions.add(new SelectOption('ceredigion','Ceredigion'));
            cityOptions.add(new SelectOption('llanelli','Llanelli'));
        } else if(sta == 'Midlands') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('coventry','Coventry'));
            cityOptions.add(new SelectOption('birmingham','Birmingham'));
            cityOptions.add(new SelectOption('derby','Derby'));
        } else if(sta == 'Victoria') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('albertpark','Albert Park'));
            cityOptions.add(new SelectOption('altona','Altona'));
            cityOptions.add(new SelectOption('bass','Bass'));
        } else if(sta == 'Tasmania') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('central','Central'));
            cityOptions.add(new SelectOption('hobart','Hobart'));
            cityOptions.add(new SelectOption('launceston','Launceston'));
        } else if(sta == 'Queensland') {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('','-- None --'));
            cityOptions.add(new SelectOption('wide-bay–burnett','Wide Bay–Burnett'));
            cityOptions.add(new SelectOption('central-queensland','Central Queensland'));
            cityOptions.add(new SelectOption('mackay','Mackay'));
        } else if(String.isBlank(sta)) {
            
            cityOptions = new List<SelectOption>();
            cityOptions.add(new SelectOption('none','-- None --'));
            
        }
    }
}