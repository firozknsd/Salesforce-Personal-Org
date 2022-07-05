import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import insertContact from '@salesforce/apex/InsertFormLMS.insertContact';

import { publish, MessageContext } from 'lightning/messageService';
import recordContact from '@salesforce/messageChannel/MessageChannelName__c';

export default class InsertFormLMS extends LightningElement {

    @wire(MessageContext)
    messageContext;

    contact = {
        FirstName : '',
        LastName : '',
        Email : ''
    };
    @track label = 'Something getting wrong...!';
    @track variant = 'error';
    @track title = 'Error !';
    handleInsert(event) {
        this.contact = {
            FirstName : this.template.querySelector('.firstName').value,
            LastName : this.template.querySelector('.lastName').value,
            Email : this.template.querySelector('.email').value
        };

        
        insertContact({contactObj : this.contact}).then(result => {
            if(result) {
                this.label = 'Record Successfully Inserted';
                this.variant = 'success';
                this.title = 'Inserted';
            }
            this.showToast(this.label, this.variant ,this.title);

            this.template.querySelector('.firstName').value = '';
            this.template.querySelector('.lastName').value = '';
            this.template.querySelector('.email').value = '';

            const payload = { recordId: JSON.stringify(result) };
            publish(this.messageContext, recordContact, payload);

        }).catch(error=> {
            console.log(JSON.stringify(error));
            this.showToast(this.label, this.variant, this.title);
        })

    }
    showToast(label, variant, title) {

        const evt = new ShowToastEvent({
            title: title,
            message: label,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}