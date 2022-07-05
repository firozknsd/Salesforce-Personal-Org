import { LightningElement, wire, track } from 'lwc';
//import contactNamesList from '@salesforce/apex/SearchContactByCityController.contactNamesList';
import contactList from '@salesforce/apex/SearchContactByCityController.getContacts';
//import citiesName from '@salesforce/apex/SearchContactByCityController.citiesName';

export default class SearchContactByCity extends LightningElement {
    
    @track contacts = [];
    //@wire(citiesName, { variableName : '$cboCityName' })cboCityNames;

    /*@track cboCityNames/* = [
        {label :'All', value:'all'},
        {label :'Ajmer', value:'ajmer'},
        {label :'Jaipur', value:'jaipur'}
    ];*/
    columns = [
        { label: 'First Name', fieldName: 'firstName' },
        { label: 'Last Name', fieldName: 'lastName' },
        { label: 'Phone', fieldName: 'phone', type: 'phone' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
        { label: 'City', fieldName: 'MailingCity', type: 'text' },
    ];
    @wire( contactList )getContacts(data, error) {
        if(data) {
            this.contacts = JSON.stringify(data);
            console.log('Data', this.contacts);
        } else {
            console.log('Error', error);
        }
    }
    /*createContact() {

        let contactObj = this.template.querySelectorAll(".clsFirst");
        
        

        this.contact = JSON.parse(JSON.stringify(this.contact));
       
        contactNamesList({ contactList : this.contact }).then(result => {
                console.log('Result----'+result);
            })
            .catch(error=>{
                    console.log('Error ----'+JSON.stringify(error));
            });
    }
    handleOptions(event){
        this.accountRecordId = event.target.value;
        console.log("Account Record Id = " + this.accountRecordId);
        
    }*/
}