import { LightningElement, track, wire, api } from 'lwc';
import  findCaseStatus  from '@salesforce/apex/CaseProgressBarController.findCaseStatus';
export default class CaseProgressBar extends LightningElement {

    @track picklistValues = ['Discovery', 'Research', 'Processing' , 'Submitted', 'Approved'];
    @api recordId;
    @track status;
    @track currentItem = 0;
    @track background = {};

    @track subPicklistValue = ['NeedMoreInformation', 'AwaitingIntroduction', 'CustomMatarials', 'AwaitingResponse', 'Accepted', 'RevisionNeeded'];
    @track currentSubStatus = 'Accepted';
    @track currentSubStatusItem = 0;
    @track subStatusBackground = {}; 
    
    @wire(findCaseStatus, { caseId : '$recordId' })
    getStatus({ error, data }) {
        if(data) {
            this.status = data.Status;
            for(let i=0; i<this.picklistValues.length; i++) {
                if(this.picklistValues[i] == data.Status) {
                    this.currentItem = i;
                    this.background[data.Status] = 'slds-size_2-of-1 div-border '+this.picklistValues[this.currentItem]+' background-color-blue';
                }
            }
            for(let i=0; i<this.currentItem; i++) {
                this.background[this.picklistValues[i]] = 'slds-size_2-of-1 div-border '+this.picklistValues[i]+' background-color-green';
            }
            for(let i=this.currentItem+1 ; i<this.picklistValues.length; i++) {
                this.background[this.picklistValues[i]] = 'slds-size_2-of-1 div-border '+this.picklistValues[i]+' background-color-grey';
            }

            // Sub status find and search.
            
            for(let i=0; i<this.subPicklistValue.length; i++) {
                if(this.subPicklistValue[i] == this.currentSubStatus) {
                    this.currentSubStatusItem = i;
                    this.subStatusBackground[this.currentSubStatus] = this.subPicklistValue[this.currentSubStatusItem] +' background-color-blue';
                }
            }

            for(let i=0; i<this.currentSubStatusItem; i++) {
                this.subStatusBackground[this.subPicklistValue[i]] = this.subPicklistValue[i] + ' background-color-green';
            }

            for(let i = this.currentSubStatusItem + 1 ; i < this.subPicklistValue.length; i++) {
                this.subStatusBackground[this.subPicklistValue[i]] = this.subPicklistValue[i] + ' background-color-grey';
            }
            
        } else {
            console.log('Errors : ',error);
        }
    }
}