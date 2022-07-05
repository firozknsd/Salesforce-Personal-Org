public class PaginationWithRadioButtonsController {
    public PaginationWithRadioButtonsController(){
        
    }
	@AuraEnabled(cacheable=true)
    public static List<Contact> contactList() {
        return [SELECT id, Name, Phone, Email FROM Contact];
    }
    @AuraEnabled
    public static List<Contact> searchList(String name,String email, String phone) {
        String query = 'SELECT Id, Name, Email, Phone FROM Contact WHERE';
        
        if(name != '') {
            query += ' Name LIKE \'%' + name + '%\''; 
        }
        
        if(email != '' && name == '' ) {
            query += ' Email LIKE \'%'+ email + '%\'';
        } else if(email != '' && name != '' ) {
            query += ' AND Email LIKE \'%'+ email + '%\'';
        }
        
        if(phone != '' && name == '' && email == '') {
            query += ' Phone = \''+ phone + '\'';
        } else if(phone != '' && name != '') {
             query += ' AND phone = \''+ phone + '\'';
        } else if(phone != '' && email != '') {
            query += ' AND phone = \''+ phone + '\'';
        } else if(phone != '' && name != '' && email != '') {
            query += ' AND phone = \''+ phone + '\'';
        }
        return Database.query(query);
    }
}