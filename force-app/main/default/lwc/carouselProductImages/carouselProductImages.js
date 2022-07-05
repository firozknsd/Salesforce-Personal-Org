import { LightningElement, api } from 'lwc';

export default class CarouselProductImages extends LightningElement {
    @api productInfo;
    connectedCallback() {
        this.productInfo = JSON.parse(JSON.stringify(this.productInfo));
    }
}