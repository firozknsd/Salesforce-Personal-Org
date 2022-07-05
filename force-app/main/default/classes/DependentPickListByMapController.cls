public class DependentPickListByMapController {
    public Map<String,List<SelectOption>> countryMap{get;set;}
    public DependentPickListByMapController() {
        countryMap = new Map<String,List<SelectOption>>();
        
        List<SelectOption> countryOptions = new List<SelectOption>();
        countryOptions.add(new SelectOption('','-None-'));
        countryOptions.add(new SelectOption('rajasthan','Rajasthan'));
        countryOptions.add(new SelectOption('madhyapradesh','Madhyapradesh'));
        countryOptions.add(new SelectOption('utterpradesh','Utterpradesh'));
        
        countryMap.put('INDIA',countryOptions);
        
        countryOptions = new List<SelectOption>();
        countryOptions.add(new SelectOption('','-None-'));
        countryOptions.add(new SelectOption('queensland','Queensland'));
        countryOptions.add(new SelectOption('victoria','Victoria'));
        countryOptions.add(new SelectOption('tasmania','Tasmania'));
        
        countryMap.put('AUSTRALIA',countryOptions);
        
        
    }
}