import { LightningElement, track } from 'lwc';

export default class IconsChange extends LightningElement {
    @track iconvalue;
    @track num = 0;
    constructor() {
        super();
        this.iconvalue = "custom:custom23";
    }
    handleChangeMax() {
        this.num++;
        this.iconvalue = "custom:custom" + this.num;
    }
    handleChangeMin() {
        if(this.num > 0) {
            this.num--;
            this.iconvalue = "custom:custom" + this.num;    
        }
    }
}