import { LightningElement, wire } from 'lwc';
import { registerListener } from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';

export default class SubscriberAddOrEdit extends LightningElement {
    dataList = {};
    columns = [
        {label: 'Product'},
        {label: 'Qty'},
        {label: 'Prize'}
    ];
    pageRef = '';

    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener("showData", this.catchData, this);
    }
    catchData(data) {
        this.dataList = {
            product : data[0],
            qty : data[1],
            prize : data[2],
        };
        alert(this.dataList.product + this.dataList.qty + this.dataList.prize);
    }

}