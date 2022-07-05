import { LightningElement, wire, track} from 'lwc';
import  accountList from '@salesforce/apex/ShowAccountsDropDownController.accountList';
import contactForShow from '@salesforce/apex/ShowAccountsDropDownController.contactForShow';
import opportunityForShow from '@salesforce/apex/ShowAccountsDropDownController.opportunityForShow';
let i=0;
export default class ShowAccountsDropDown extends LightningElement {

    @track items = [];
    @track value = '';

    @track chosenValue = '';
    @track showInfo = false;
    datalist=[];
    @wire (accountList) accounts({error, data}){
        if(data){
            for(i=0; i<data.length; i++)  {
                this.items = [...this.items ,{value: data[i].Id , label: data[i].Name} ];
            }
            this.datalist = data;
        }
    }
    get roleOptions() {
        return this.items;
    }
    selectedValues = {
        Id : '',
        Name : '',
        AccountNo : 0,
        Phone : 0,
        Fax : 0,
        State : '',
        City : ''
    };
    contactDetail = {
        FirstName : '',
        LastName : '',
        Email : '',
        Phone : 0
    };
    opportunityDetail = {
        Name : '',
        StageName : '',
        CloseDate : 0,
        Amount : 0
    };
    handleChange(event) {
        const selectedOption = event.detail.value;
        //console.log('selected value=' + selectedOption);
        this.chosenValue = selectedOption;
        this.showInfo = true;

        for(i=0; i<this.datalist.length; i++) {
            if(this.chosenValue == this.datalist[i].Id) {
                console.log(this.datalist[i].Name);
                this.selectedValues = {
                    Id : this.datalist[i].Id,
                    Name : this.datalist[i].Name,
                    AccountNo : this.datalist[i].AccountNumber,
                    Phone : this.datalist[i].Phone,
                    Fax : this.datalist[i].Fax,
                    State : this.datalist[i].BillingState,
                    City : this.datalist[i].BillingCity
                }
                break;
            }
        }
        
        contactForShow({contactLastName : this.selectedValues.Name}).then(result => {
            this.contactDetail = {
                FirstName : result.FirstName,
                LastName : result.LastName,
                Email : result.Email,
                Phone : result.Phone
            };
        })
        
        opportunityForShow({opportunityName : this.selectedValues.Name}).then(result => {
            this.opportunityDetail = {
                Name : result.Name,
                StageName : result.StageName,
                CloseDate : result.CloseDate,
                Amount : result.Amount
            };
        })

    }
}