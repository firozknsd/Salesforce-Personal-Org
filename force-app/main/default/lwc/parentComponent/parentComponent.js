import { LightningElement , track} from 'lwc';

export default class ParentComponent extends LightningElement {
    @track messageVar;
    @track parentMessage;
    handleShowChild() {
        this.messageVar = 'Parent Component Message';
    }
    showMessage(event) {
        this.parentMessage = event.detail;
    }
}