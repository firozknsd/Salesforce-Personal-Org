import { LightningElement, wire,track } from 'lwc';
import  accountList from '@salesforce/apex/ShowAccountsDropDownController.accountList';

export default class CustomFilterDashboard extends LightningElement {
    
    @track data = [];
    @track value = [];
    stateValue = [];

    get options() {
        return [
            { label: 'Name', value: 'Name' },
            { label: 'Account Number', value: 'AccountNumber' },
            { label: 'Phone', value: 'Phone' }
        ];
    }
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Account Number', fieldName: 'AccountNumber', type: 'Number' },
        { label: 'Phone', fieldName: 'Phone', type: 'Phone' },
        { label: 'Billing State', fieldName: 'BillingState'}
    ];

    get stateOptions() {
        return [
            { label: 'Rajasthan', value: 'Rajasthan' },
            { label: 'Madheye Pradesh', value: 'Madheye Pradesh' },
            { label: 'Uttar Pradesh', value: 'Uttar Pradesh' }
        ];
    }

    @wire (accountList) accounts(result){
        if(result.data){
            this.tempData = result.data;
            this.data = result.data;
            console.log('this,data : ',this.data);
        }
    }
    optionArray = [];
    get selectedValues() {
        return this.value.join(',');
    }

    handleChange(e) {
        this.value = JSON.parse(JSON.stringify(e.detail.value));
        
        this.columns = [];
        
        if(this.value.length > 0) {
            this.value.forEach(val => {
                if(val == 'Name') {
                    this.columns.push({ label: 'Name', fieldName: 'Name' });
                } else if(val == 'AccountNumber') {
                    this.columns.push({ label: 'Account Number', fieldName: 'AccountNumber' });
                } else if(val == 'Phone') {
                    this.columns.push({ label: 'Phone', fieldName: 'Phone' });
                }    
            });
        } else {
            this.columns = [
                { label: 'Name', fieldName: 'Name' },
                { label: 'Account Number', fieldName: 'AccountNumber', type: 'Number' },
                { label: 'Phone', fieldName: 'Phone', type: 'Phone' }
            ];
        }
    }

    stateData = [];

    handleStateChange(e) {
        this.data = [];
        this.stateData = [];
        this.stateValue = JSON.parse(JSON.stringify(e.detail.value));
       
        if(this.stateValue.length > 0) {
            this.tempData.forEach(val => {
                if(val.BillingState === 'Rajasthan' && this.stateValue.includes('Rajasthan')) {
                    this.stateData.push(val);
                }
                if(val.BillingState === 'Madheye Pradesh' && this.stateValue.includes('Madheye Pradesh')) {
                    this.stateData.push(val);
                }
                if(val.BillingState === 'Uttar Pradesh' && this.stateValue.includes('Uttar Pradesh')) {
                    this.stateData.push(val);
                }  
            });

            this.data = this.stateData;

        } else {
            this.stateData = [];
            this.data = this.tempData;
        }

        console.log('this.data : ',this.data);
        console.log('stateData : ',this.stateData);
    }
}