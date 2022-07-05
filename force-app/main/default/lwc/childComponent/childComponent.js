import { LightningElement ,api, track} from 'lwc';

export default class ChildComponent extends LightningElement {
    @api messageVar; 
    @track messageForParent;

    handleShowparent() {
        this.messageForParent='Child Component Message';
        const selectedEvent = new CustomEvent('selected', { 
            detail: this.messageForParent 
        });
        this.dispatchEvent(selectedEvent);
    }
}