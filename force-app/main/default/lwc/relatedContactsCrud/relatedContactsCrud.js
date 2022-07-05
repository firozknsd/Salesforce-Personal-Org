import { LightningElement, api, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import getContacts from '@salesforce/apex/RelatedContactsCrudController.getContacts';
import insertContact from '@salesforce/apex/RelatedContactsCrudController.insertContact';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RelatedContactsCrud extends LightningElement {

    @api recordId;
    @track dataList;
    wireList;
    @track isLoading = true;
    columns = [
        
        {label : 'First Name', fieldName : 'FirstName', type : 'text', editable: true},
        {label : 'Last Name', fieldName : 'LastName', type : 'text', editable: true},
        {label : 'Email', fieldName : 'Email', type : 'email', editable: true},
        {label : 'Phone', fieldName : 'Phone', type : 'phone', editable: true},
        {
            type: "button",
            fixedWidth: 90,
            typeAttributes: {
                label: 'Delete',
                name:'Delete',
                variant: 'destructive',
                disabled: false,
                value: 'delete'
            }
        },
    ];

    contact = {
        FirstName : '',
        LastName : '',
        Email : '',
        Phone : '',
        AccountId : '',
    };

    @wire(getContacts, { recordId: '$recordId'})
    allContacts(result) {
        this.wireList = result;
        if(result.data) {
            this.dataList = result.data;
        } else {
            console.log('Error : ', result.error);
        }
    }
    handleInsert(event) {
        this.isLoading = false;
        this.contact = {
            FirstName : this.template.querySelector('.inptFirstName').value,
            LastName : this.template.querySelector('.inptLastName').value,
            Email : this.template.querySelector('.inptEmail').value,
            Phone : this.template.querySelector('.inptPhone').value,
            AccountId : this.recordId
        }
        
        insertContact({contactObj : this.contact}).then(result => {
            console.log('result : ', result); 
            if(result) {
                this.refresh();

                this.template.querySelector('.inptFirstName').value = '';
                this.template.querySelector('.inptLastName').value = '';
                this.template.querySelector('.inptEmail').value = '';
                this.template.querySelector('.inptPhone').value = '';

                this.isLoading = true;
            }
        })
    }
    refresh() {
        return refreshApex(this.wireList); 
    }

    callRowAction(event) {
        var deleteContact = JSON.parse(JSON.stringify(event.detail.row));
        console.log('CallRowAction : ',deleteContact);
        deleteRecord(deleteContact.Id)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Is  Deleted',
                        variant: 'success',
                    }),
                );
                this.refresh();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error While Deleting record',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }

    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            this.saveDraftValues = [];
            return this.refresh();
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.saveDraftValues = [];
        });
    }


}