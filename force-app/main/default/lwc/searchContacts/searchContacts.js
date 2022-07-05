import { LightningElement } from 'lwc';
import  searchList from '@salesforce/apex/SearchContactsLWCController.searchList';

export default class SearchContacts extends LightningElement {

    dataList;
    tempRecordList;
    searchValue = '';
    pageSize = '5';
    last = 0;
    first = 1;
    totalRecountCount = 0;
    totalPage = 0;
    page = 1;
    flag = false;

    // This is responsible for showing Header in data table and its also responsible for bind fields.
    columns = [
        {label : 'Name', fieldName : 'Name', type : 'text'},
        {label : 'Email', fieldName : 'Email', type : 'email'},
        {label : 'Account Name', fieldName : 'AccountId', type : 'text'},
        {label : 'Phone', fieldName : 'Phone', type : 'phone'},
        {label : 'Type', fieldName : 'Type__c', type : 'text'},
    ];

    // This is responsible for showing data in dropdown.
    get options() {
        return [
            {label : '5', value : '5'},
            {label : '10', value : '10'},
            {label : '15', value : '15'},
            {label : '20', value : '20'},
            {label : '100', value : '100'},
        ];
    }

    constructor() {
        super();
        this.recordFiller();        //name change
    }

    //Fill data table
    recordFiller() {        // Name Change of this method
        searchList({searchValue : this.searchValue}).then(result => {
            this.flag = false;
            this.totalRecountCount = result.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
            this.tempRecordList = result;

            /*this.tempRecordList = result.map(row => {
                if(Account) {
                    return {...row, accountName: row.Account.Name}
                }
            })*/

            this.dataList = this.tempRecordList.slice(0, this.pageSize);
            this.last = this.pageSize;
            
            if(this.dataList.length == 0) {
                this.flag = true;
            } 
        })
    }

    // When user click on search button this method will be execute.
    handleSearch() {
        this.searchValue = this.template.querySelector(".searchBox").value;
        this.recordFiller();
        this.handleFirst();
    }


    // When user change dropdown items this method will be execute and set pageSize value.
    handleChange(event) {
        this.pageSize = event.detail.value;
        this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
        this.dataList = this.tempRecordList.slice(0, parseInt(this.pageSize));
        this.last = this.pageSize;
        this.handleFirst();
        
    }

    // When user click on First button this method will be execute.
    handleFirst() {
        this.page = 1; 
        this.displayRecordPerPage(this.page);
    }

    // When user click on Previous button this method will be execute.
    handlePrevious() {
        if (this.page > 1) {
            this.page = this.page - 1;  //this.page--;
            this.displayRecordPerPage(this.page);
        }
    }

    // When user click on Next button this method will be execute.
    handleNext() {
        if((this.page < this.totalPage) && this.page !== this.totalPage) {
            this.page = this.page + 1;  //this.page++;
            this.displayRecordPerPage(this.page);            
        }
    } 

    // When user click on Last button this method will be execute.
    handleLast() {
        this.page = this.totalPage;
        this.displayRecordPerPage(this.page);    
    } 

    // When user click on First button this method will be execute.
    displayRecordPerPage(page) {
        this.first = (page - 1) * this.pageSize;
        this.last = this.pageSize * page;
        this.last = this.last > this.totalRecountCount
                            ? this.totalRecountCount : this.last; 

        this.dataList = this.tempRecordList.slice(this.first, this.last);
        this.first = this.first + 1;
    } 
    
    // This is responsible for show and hide First and previous buttons.
    get disableFirstPrevious() {
		if(this.page == 1) { 
            return true;
		}
		return false;
	}
    
    // This is responsible for show and hide Next and Last buttons.
    get disableNextLast() {
		if((this.pageSize * this.page) < this.totalRecountCount) { 
			return false;
		}
		return true;
	}
}