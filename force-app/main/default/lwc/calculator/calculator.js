import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
    resultValue = "";
    textFirst;
    textSecond;
    currentClass='.currentClass';


    handleAdd() {
        this.template.querySelector(this.currentClass).className = 'addClass';
        this.currentClass = '.addClass';

        this.resultValue = 'Addition is : ' + (parseInt(this.template.querySelector(".textFirst").value) + parseInt(this.template.querySelector(".textSecond").value));
    }
    handleSub() {
        this.template.querySelector(this.currentClass).className = 'subClass';
        this.currentClass = '.subClass';

        this.resultValue = 'Substration is : ' + (parseInt(this.template.querySelector(".textFirst").value) - parseInt(this.template.querySelector(".textSecond").value));
    }
    handleMul() {
        this.template.querySelector(this.currentClass).className = 'mulClass';
        this.currentClass = '.mulClass';

        this.resultValue = 'Multiplication is : ' + (parseInt(this.template.querySelector(".textFirst").value) * parseInt(this.template.querySelector(".textSecond").value));
    }
    handleDiv() {
        this.template.querySelector(this.currentClass).className = 'divClass';
        this.currentClass = '.divClass';

        this.textFirst = parseInt(this.template.querySelector(".textFirst").value);
        this.textSecond = parseInt(this.template.querySelector(".textSecond").value);
        if(this.textSecond>0) {
            this.resultValue = (this.textFirst / this.textSecond).toFixed(2);
            this.resultValue = 'Division is : '+this.resultValue;
        } else {
            this.resultValue = 'Enter valid value!!';
        }
    }
    handleMod() {
        this.template.querySelector(this.currentClass).className = 'modClass';
        this.currentClass = '.modClass';

        this.resultValue = 'Modulus is : ' + (parseInt(this.template.querySelector(".textFirst").value) - parseInt(this.template.querySelector(".textSecond").value));
    }
}