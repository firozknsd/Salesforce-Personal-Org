import {LightningElement, wire, track, api } from 'lwc';
import  contactList from '@salesforce/apex/CrudRecordsController.contactList';
import  deleteRecord from '@salesforce/apex/CrudRecordsController.deleteRecord';
import  cloneRecord from '@salesforce/apex/CrudRecordsController.cloneRecord';
import {NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';

export default class CrudRecords extends NavigationMixin(LightningElement) {

    @track isCloneOpen=false;

    dataList;
    @wire (contactList) contacts({error, data}){
        if(data){
            this.dataList = data;
        }
    }
    columns = [
        {
            label: 'Action',type: "button",
            fixedWidth: 90,
            typeAttributes: {
                label: 'Edit',
                name:'Edit',
                variant: 'brand-outline',
                disabled: false,  
                value: 'edit',
                class: 'scaled-down'
            }
        },
        {
            type: "button",
            fixedWidth: 90,
            typeAttributes: {
                label: 'Detail',
                name:'Detail',
                name:'Detail',
                variant: 'destructive-text',
                disabled: false,
                value: 'detail',
            }
        },
        
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
        {
            type: "button",
            fixedWidth: 90,
            typeAttributes: {
                label: 'Clone',
                name:'Clone',
                variant: 'brand',
                disabled: false,
                value: 'clone'
            }
        },
        {label : 'Name', fieldName : 'Name', type : 'text'},
        {label : 'Email', fieldName : 'Email', type : 'email'},
        {label : 'Phone', fieldName : 'Phone', type : 'phone'},
    ];

    contact = {
        FirstName : '',
        LastName : '',
        Email : '',
        Phone : '',
        Designation__c : '',
        Salary__c : ''
    };
    
    callRowAction(event) {
        var record = event.detail.row;

        const actionName = event.currentTarget;
        console.log('##');
        console.log(JSON.stringify(event.currentTarget.value));

        if(actionName=='Edit') {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: record.Id,
                    objectApiName: 'Contact',
                    actionName: 'edit'
                }
            });
        } else if(actionName=='Detail') {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId : record.Id,
                    objectApiName: 'Contact',
                    actionName: 'view'
                }
            });
        } else if(actionName=='Delete') {
            deleteRecord({recordId : record.Id}).then(result => {
                window.location.reload();
                
                //refreshApex(this.dataList);
            })

        } else if(actionName=='Clone') {
            this.isCloneOpen=true;

            console.log('$');
            console.log(JSON.stringify(record));

            this.contact = {
                FirstName : record.FirstName,
                LastName : record.LastName,
                Email : record.Email,
                Phone : record.Phone,
                Designation__c : record.Designation__c,
                Salary__c : record.Salary__c
            };
        }
    }
    handleCloneOkButton() {
        this.isCloneOpen=false;
        
        cloneRecord({contact : this.contact}).then(result => {
            console.log(JSON.stringify(result));
            window.location.reload();
        }).catch(error=> {
            console.log(JSON.stringify(error));
        }) 
    }
    handleCloseModal() {
        this.isCloneOpen=false;
    }
}