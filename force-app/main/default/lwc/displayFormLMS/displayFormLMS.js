import { LightningElement, api, wire, track } from 'lwc';
import { subscribe, APPLICATION_SCOPE, MessageContext, } from 'lightning/messageService';
import recordContact from '@salesforce/messageChannel/MessageChannelName__c';
import Email from '@salesforce/schema/Contact.Email';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';

export default class DisplayFormLMS extends LightningElement {

    subscription = null;

    @wire(MessageContext)
    messageContext;

    fields = [FirstName, LastName, Email];
    recordId;
    objName = 'Contact';

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe ( 
                this.messageContext, 
                recordContact, 
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }
    handleMessage(message) {
        this.recordId = JSON.parse(JSON.stringify(message.recordId));
        console.log('recordId : '+this.recordId);
    }

}