import { LightningElement, wire} from 'lwc';
import contactList from '@salesforce/apex/ContactListShowViaCheckboxController.contactList';

export default class ContactListShowViaCheckboxField extends LightningElement {
    contacts;
    boolNameVisible = true;
    boolEmailVisible = false;
    boolPhoneVisible = false;
    flag=true;
    
    @wire(contactList)
    allContacts({ error, data }) {
        if(data) {
            this.contacts = data;
            this.tempContactList = this.contacts;
        }
    }
    handleNameCheckboxChange(event) {
        this.flag = this.template.querySelector('.masterNameCheckBox').checked;
        this.boolNameVisible = this.flag;

        if(this.boolPhoneVisible==false && this.boolEmailVisible==false && this.boolNameVisible==false) {
            this.boolNameVisible = true;
        }
    }
    handlePhoneCheckboxChange(event) {
        this.flag = this.template.querySelector('.masterPhoneCheckBox').checked;
        this.boolPhoneVisible = this.flag;

        if(this.boolPhoneVisible==false && this.boolEmailVisible==false && this.boolNameVisible==false) {
            this.boolNameVisible = true;
        }
    }
    handleEmailCheckboxChange(event) {
        this.flag = this.template.querySelector('.masterEmailCheckBox').checked;
        this.boolEmailVisible = this.flag;

        if(this.boolPhoneVisible==false && this.boolEmailVisible==false && this.boolNameVisible==false) {
            this.boolNameVisible = true;
        }
    }
    handleAllCheckboxChange(event) {
        this.flag = this.template.querySelector('.masterAllCheckBox').checked;
        this.boolNameVisible = true;
        this.boolEmailVisible = this.flag;
        this.boolPhoneVisible = this.flag;

        if(this.boolPhoneVisible==false && this.boolEmailVisible==false && this.boolNameVisible==false) {
            this.boolNameVisible = true;
        }
    }
}