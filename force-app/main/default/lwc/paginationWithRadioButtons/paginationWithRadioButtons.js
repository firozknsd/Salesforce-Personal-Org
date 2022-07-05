import { LightningElement, wire, track } from 'lwc';
import  contactList from '@salesforce/apex/PaginationWithRadioButtonsController.contactList'
import  searchList from '@salesforce/apex/PaginationWithRadioButtonsController.searchList'

export default class PaginationWithRadioButtons extends LightningElement {

    @track dataList;
    tempList;
    name;
    phone;
    email;

    @wire (contactList) contacts({error, data}){
        if(data){
            this.tempList = data;
            this.dataList = data;
           
        }
        if(error) {
            console.log(error);
        }
    }
    
    columns = [
        
        {label: 'Name', fieldName: 'Name', type: 'text'},
        {label: 'Email', fieldName: 'Email', type: 'email'},
        {label: 'Phone', fieldName: 'Phone', type: 'phone'},
    ];

    get options() {
        return [
            {label : 'All', value : 'all'},
            {label : '5', value : '5'},
            {label : '10', value : '10'},
            {label : '20', value : '20'},
            {label : '50', value : '50'}
        ];
    }
    
    numberArray=[1,2,3,4,5];

    selectedValue = "All";
    
    handleRecordValue(event){
        this.selectedValue =  parseInt(event.target.value);

        if(this.selectedValue == 5){
            this.dataList = this.tempList.slice(0,5);
        }else if(this.selectedValue == 10){
            this.dataList = this.tempList.slice(0,10);
        }else if(this.selectedValue == 20){
            this.dataList = this.tempList.slice(0,20);
        }else if(this.selectedValue == 50){
            this.dataList = this.tempList.slice(0,50);
        }else{
            this.dataList = this.tempList;
        }
    }

    handleGetValue(event){
        this.name =  this.template.querySelector('.getName').value;
        this.phone =  this.template.querySelector('.getPhone').value;
        this.email =  this.template.querySelector('.getEmail').value;
        console.log(this.name);
        console.log(this.phone);
        console.log(this.email);
        searchList({name : this.name, email : this.email, phone : this.phone}).then(result => {
            
            this.dataList = result;
        }).catch(error => {
            console.log('%%%%');
            console.log(error);
        });

    }

}