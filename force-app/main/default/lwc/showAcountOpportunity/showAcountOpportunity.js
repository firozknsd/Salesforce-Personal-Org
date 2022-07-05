import { LightningElement, wire, track} from 'lwc';
import accountList from '@salesforce/apex/ShowAccountOpportunity.accountList';
import opportunityForShow from '@salesforce/apex/ShowAccountOpportunity.opportunityForShow';
import saveOpportunity from '@salesforce/apex/ShowAccountOpportunity.saveOpportunity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ShowAcountOpportunity extends LightningElement {
    
    @track items = [];
    @track value = '';
    datalist=[];
    stageValue = '';
    currentAccountId;

    opportunityDetail = {
        Name : '',
        StageName : '',
        CloseDate : 0,
        Amount : 0
    };
    
    get roleOptions() {
        return this.items;
    }
    
    @wire (accountList) accounts({error, data}){
        if(data){
            for(var i=0; i<data.length; i++)  {
                this.items = [...this.items ,{value: data[i].Id , label: data[i].Name} ];
            }
            this.datalist = data;
        }
    }

    get options() {
        return [
            { label: 'Prospecting', value: 'Prospecting' },
            { label: 'Qualification', value: 'Qualification' },
            { label: 'Value Proposition', value: 'Value Proposition.' },
        ];
    }

    columns = [
        {label : 'Name', fieldName : 'Name', type : 'text'},
        {label : 'StageName', fieldName : 'StageName', type : 'text'},
        {label : 'CloseDate', fieldName : 'CloseDate', type : 'Date'},
        {label : 'Amount', fieldName : 'Amount', type : 'Integer'},
    ];

    handleChange(event) {
        this.currentAccountId = event.detail.value;
        opportunityForShow({accountId : this.currentAccountId}).then(result => {
            this.opportunityDetail = result;
        })
    }

    handleStageNameChange(event) {
        this.stageValue = event.detail.value;
    }

    handleSave() {
        var opportunityObject = {
            AccountId : this.currentAccountId,
            Name : this.template.querySelector('.oppName').value,
            StageName : this.stageValue,
            CloseDate : this.template.querySelector('.closeDate').value,
            Amount : this.template.querySelector('.amount').value,
        }

        saveOpportunity({ opportunity : opportunityObject }).then(result => {
            if(result) {
                this.showSuccessToast();
                this.stageValue = '';
                this.template.querySelector('.oppName').value = '';
                this.template.querySelector('.closeDate').value = '';
                this.template.querySelector('.amount').value = '';
            }
        }).catch(error => {
            console.log(JSON.stringify(error));
        })
    }
    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Success',
            message: 'Opearion sucessful',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    };
}