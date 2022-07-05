import { LightningElement, api, track } from 'lwc';

export default class ProductData extends LightningElement {
    @api productRecords;
    @track productInfo = {
        id: '',
        url: [],
        name:'',
        description:'',
        price: 0,
        showPopUp: false,
    }
    handleInfo(event) {
        for(let i=0; i<this.productRecords.length; i++) {
            if(this.productRecords[i].id == event.currentTarget.dataset.id) {
                this.productInfo.id = this.productRecords[i].id;
                this.productInfo.url = this.productRecords[i].image;
                this.productInfo.name = this.productRecords[i].product.Name;
                this.productInfo.description = this.productRecords[i].product.Description;
                this.productInfo.price = this.productRecords[i].price;
                this.productInfo.showPopUp = true;
            }
        }
        const productInfoEvent = new CustomEvent('getproductinfo',{
            detail : this.productInfo
        })
        this.dispatchEvent(productInfoEvent);
    }
}