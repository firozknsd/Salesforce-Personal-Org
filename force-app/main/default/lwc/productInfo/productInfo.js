import { LightningElement, track } from 'lwc';
import productSearch from '@salesforce/apex/ProductInfoController.productSearch'

export default class ProductInfo extends LightningElement {

    @track flag = true;
    @track productInfo = {
        Name : '',
        description : '',
        image : '',
        price : 0
    }

    handleGo() {
        var productCode = this.template.querySelector('.productCode').value;
        productSearch({productCode : productCode}).then(results => {
            if(results.length > 0) {
                let result = results[0];
                this.productInfo.Name = result.Name;
                this.productInfo.description = result.Description;
                this.productInfo.image = '/servlet/servlet.FileDownload?file='+result.Attachments[0].Id;
                this.productInfo.price = results[0].PricebookEntries[0].UnitPrice;
                this.flag = true;
            } else {
                this.flag = false;
                console.log('Not Found',this.flag);
            }
        }).catch(error => {
            console.log('##:',error);
        })
    }
}