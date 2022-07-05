import { LightningElement } from 'lwc';

export default class WishListParent extends LightningElement {
    
    selectedValue;
    showContent = false;

    boolLaptop;
    boolMonitor;
    boolKeyboard;
    boolMouse;

    laptopQty;
    monitorQty;
    keyboardQty;
    mouseQty;



    boolFalse = true;
    device = [
        {
            label : 'laptop',
            value : {
                src : 'https://www.vippng.com/png/detail/178-1784001_hp-envy-x360-13-ag0034au-laptop-image-hp.png',
                price : 5000,
                offer : 30,
                description : 'This is good product as laptop.'
            }
        },
        {
            label : 'monitor',
            value : {
                src : 'https://www.asus.com/websites/global/products/68Zd0ZZfOy6gAiXw/img/main/360/MG278_00000.png',
                price : 1000,
                offer : 10,
                description : 'This is good product as monitor.'
            }
        },
        {
            label : 'keyboard',
            value : {
                src : 'https://pngimg.com/uploads/keyboard/keyboard_PNG5865.png',
                price : 500,
                offer : 0,
                description : 'This is good product as keyboard.'
            }
        },
        {
            label : 'mouse',
            value : {
                src : '',
                price : 300,
                offer : 0.2,
                description : 'This is good product as Pointing device.'
            }
        }
    ];

    label;
    src;
    price;
    offer;
    total;
    description;

    productinfo={};

    handleChange(event) {
        this.selectedValue = event.target.value;
        this.showContent = true;
        if(this.selectedValue=='laptop') {
            this.boolLaptop = true;
            this.boolMonitor = false;
            this.boolKeyboard = false;
            this.boolMouse = false;

            this.label=this.device[0].label;
            if(this.device[0].value.src != '') {
                this.src = this.device[0].value.src;
            } else {
                this.src='https://cima-afrique.org/cima/images/not-available.png';
            }
            this.price = this.device[0].value.price;
            this.offer = this.device[0].value.offer;
            this.total = this.price-((this.offer*this.price)/100);
            this.description = this.device[0].value.description;

        } else if(this.selectedValue=='monitor') {
            this.boolLaptop = false;
            this.boolMonitor = true;
            this.boolKeyboard = false;
            this.boolMouse = false;

            this.label=this.device[1].label;
            if(this.device[1].value.src != '') {
                this.src = this.device[1].value.src;
            } else {
                this.src='https://cima-afrique.org/cima/images/not-available.png';
            }
            this.price = this.device[1].value.price;
            this.offer = this.device[1].value.offer;
            this.total = this.price-((this.offer*this.price)/100);
            this.description = this.device[1].value.description;


        } else if(this.selectedValue=='keyboard') {
            this.boolLaptop = false;
            this.boolMonitor = false;
            this.boolKeyboard = true;
            this.boolMouse = false;

            this.label=this.device[2].label;
            if(this.device[2].value.src != '') {
                this.src = this.device[2].value.src;
            } else {
                this.src='https://cima-afrique.org/cima/images/not-available.png';
            }
            this.price = this.device[2].value.price;
            this.offer = this.device[2].value.offer;
            this.total = this.price-((this.offer*this.price)/100);
            this.description = this.device[2].value.description;

        } else if(this.selectedValue=='mouse') {
            this.boolLaptop = false;
            this.boolMonitor = false;
            this.boolKeyboard = false;
            this.boolMouse = true;

            this.label=this.device[3].label;
            if(this.device[3].value.src != '') {
                this.src = this.device[3].value.src;
            } else {
                this.src='https://cima-afrique.org/cima/images/not-available.png';
            }
            this.price = this.device[3].value.price;
            this.offer = this.device[3].value.offer;
            this.total = this.price-((this.offer*this.price)/100);
            this.description = this.device[3].value.description;
        }
        this.productinfo = {
            label : this.label,
            src : this.src,
            price : this.price,
            offer : this.offer,
            total : this.total,
            description : this.description
        };
    }
    handleGetQty(productQty) {
        this.laptopQty = productQty.detail.laptop;
        this.monitorQty = productQty.detail.monitor;
        this.keyboardQty = productQty.detail.keyboard;
        this.mouseQty = productQty.detail.mouse;
    }
    
}