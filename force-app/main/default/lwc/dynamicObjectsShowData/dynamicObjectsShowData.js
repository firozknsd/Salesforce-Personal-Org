import { LightningElement, track } from 'lwc';
import sendFieldNames from '@salesforce/apex/DynamicShowData.sendFieldNames';
import sendFieldsRecords from '@salesforce/apex/DynamicShowData.sendFieldsRecords'; 
sendFieldsRecords

export default class DynamicObjectsShowData extends LightningElement {
    selectedObject = '';
    @track fieldsValues = [];
    selectedFields;
    @track data = [];
    @track columns = [];
    get objectsList() {
        return [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' },
        ];
    }

    handleSelectObject(event) {
        this.selectedObject = event.detail.value;
        console.log('this.selectedObject : ',this.selectedObject);

        this.fieldsValues = [];

        sendFieldNames({ objectName : this.selectedObject}).then(result => {
            result.forEach(val => {
                this.fieldsValues.push( { label: val, value: val });
            });
            console.log('this.fieldsValues  : ',this.fieldsValues );
        }).catch(error => {
           console.log('Errorured:- '+error.body.message);
        });
    }


    get selected() {
        if (this.selectedFields) {
            return this.selectedFields.length ? this.selectedFields : 'none';
        }
    }
    

    handleSelectFields(event) {
        this.selectedFields = event.detail.value;
        let fieldsString = '';
        this.columns = [];

        this.selectedFields.forEach(val => {
            fieldsString += ',' + val;
            this.columns.push({ label: val, fieldName: val });
        });

        fieldsString = fieldsString.replace(fieldsString.charAt(0), '');

        //console.log('fieldsString : ',fieldsString);
    
        console.log('this.columns : ',this.columns);

        sendFieldsRecords({ fields : fieldsString ,objectName : this.selectedObject}).then(result => {
            console.log('result : ',result);
            this.data = result;
            // result.forEach(val => {
            //     console.log('Errorured:- '+error.body.message);
            // });
        }).catch(error => {
           console.log('Errorured:- ',error.body.message);
        });

    }


}