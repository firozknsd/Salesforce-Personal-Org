import { LightningElement ,wire} from 'lwc';
import { fireEvent } from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';
import addProduct from '@salesforce/apex/AddOrEditPublisherController.addProduct';

export default class AddOrEditPublisher extends LightningElement {
    showBlock = true;
    title='Add';
    productValue = '';
    qtyValue = '';

    productOptions = [
        {label : 'Laptop' , value : 'laptop'},
        {label : 'Keyboard' , value : 'keyboard'},
        {label : 'Mouse' , value : 'mouse'}
    ];
    qtyOptions = [
        {label : '1' , value : '1' },
        {label : '2' , value : '2' },
        {label : '3' , value : '3' }
    ];

    pageRef = '';

    @wire(CurrentPageReference) pageRef;
    dataList;
    /*
    dataList = [
        {
            product : data[0],
            qty : data[1],
            prize : data[2],
        }
    ];*/

    handleChange(event) {
        var product = this.template.querySelector('.productClass').value;
        var qty = this.template.querySelector('.qtyClass').value;
        var prize = this.template.querySelector('.prizeClass').value;
        
        addProduct({name : product, qty : qty, prize : prize}).then(result => {
            console.log('$$');
            console.log(result);
            this.dataList = result;
        })

        //var dataList = [product, qty, prize];

        fireEvent(this.pageRef, 'showData', dataList);

    }
}