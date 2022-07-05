import { LightningElement, track } from 'lwc';
import productSearch from '@salesforce/apex/ProductInfoNameWiseController.productSearch'
export default class ProductInfoNameWise extends LightningElement {
    @track flag = true;
    @track productRecords;
    @track showPopUp = false;
    @track productInfo;
    
    handleGo() {
        var productName = this.template.querySelector('.productNameSearch').value;
        productSearch({productName : productName}).then(results => {
            if(results.length > 0) {
                this.productRecords = JSON.parse(JSON.stringify(results));
                this.flag = true;
            } else {
                this.flag = false;
            }
        }).catch(error => {
            console.log('##:',error);
        })
    }
    handleShowProductInfo(productInfo) {
        this.productInfo = JSON.parse(JSON.stringify(productInfo.detail));
        this.showPopUp = this.productInfo.showPopUp;
    }
    submitDetails() {
        this.showPopUp = false;
    }
}