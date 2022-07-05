import { LightningElement } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    resultValue = "";
    textFirst;
    textSecond;

    // handleAdd() {
    //     this.resultValue = parseFloat(this.template.querySelector(".textFirst").value) + parseFloat(this.template.querySelector(".textSecond").value);
    // }
    // handleSub() {
    //     this.resultValue = parseFloat(this.template.querySelector(".textFirst").value) - parseFloat(this.template.querySelector(".textSecond").value);
    // }
    // handleMul() {
    //     this.resultValue = parseFloat(this.template.querySelector(".textFirst").value) * parseFloat(this.template.querySelector(".textSecond").value);
    // }
    // handleDiv() {
    //     this.textFirst = parseFloat(this.template.querySelector(".textFirst").value);
    //     this.textSecond = parseFloat(this.template.querySelector(".textSecond").value);
    //     if(this.textSecond>0) {
    //         this.resultValue = (this.textFirst / this.textSecond).toFixed(2);
    //     } else {
    //         this.resultValue = 'Enter valid value!!';
    //     }
    // }
    handleCalculate(event) {
        let sign = event.target.value;
        if(sign == 'Add') {
            this.resultValue = parseFloat(this.template.querySelector(".textFirst").value) + parseFloat(this.template.querySelector(".textSecond").value);
        } else if(sign == 'Sub') {
            this.resultValue = parseFloat(this.template.querySelector(".textFirst").value) - parseFloat(this.template.querySelector(".textSecond").value);
        } else if(sign == 'Mul') {
            this.resultValue = parseFloat(this.template.querySelector(".textFirst").value) * parseFloat(this.template.querySelector(".textSecond").value);
        } else if(sign == 'Div') {
            this.textFirst = parseFloat(this.template.querySelector(".textFirst").value);
            this.textSecond = parseFloat(this.template.querySelector(".textSecond").value);
            if(this.textSecond>0) {
                this.resultValue = (this.textFirst / this.textSecond).toFixed(2);
            } else {
                this.resultValue = 'Enter valid value!!';
            }
        }//sfdx:force:open:org 
    }
}