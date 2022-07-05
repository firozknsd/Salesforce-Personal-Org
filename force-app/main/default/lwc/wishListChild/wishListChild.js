import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class WishListChild extends LightningElement {
   
    @api productinfo;

    addLaptopCount=0;
    addMonitorCount=0;
    addKeyboardCount=0;
    addMouseCount=0;

    handleAdd() {
        if(this.productinfo.label=='laptop') {
            if(this.addLaptopCount<3) {
                this.addLaptopCount++;
            } else {
                this.showToast(this.productinfo.label);
            }
        } else if(this.productinfo.label=='monitor') {
            if(this.addMonitorCount<3) {
                this.addMonitorCount++;
            } else {
                this.showToast(this.productinfo.label);
            }
        } else if(this.productinfo.label=='keyboard') {
            if(this.addKeyboardCount<3) {
                this.addKeyboardCount++;
            } else {
                this.showToast(this.productinfo.label);
            }
        } else if(this.productinfo.label=='mouse') {
            if(this.addMouseCount<3) {
                this.addMouseCount++;
            } else {
                this.showToast(this.productinfo.label);
            }
        }

        const productQty = {
            laptop : this.addLaptopCount,
            monitor : this.addMonitorCount,
            keyboard : this.addKeyboardCount,
            mouse : this.addMouseCount
        };

        const myQtyEvent = CustomEvent('getqtyevent',{
            detail : productQty
        })
        this.dispatchEvent(myQtyEvent);
    }
    showToast(label) {
        const evt = new ShowToastEvent({
            title: 'Limit Over',
            message: 'Thankyou for choosing this '+label+'.',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}