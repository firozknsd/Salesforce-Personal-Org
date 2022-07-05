import { LightningElement, api, wire, track } from 'lwc';
import projectTaskList from '@salesforce/apex/ShowProjectTaskStatusController.projectTaskList';

export default class ShowProjectStatusBar extends LightningElement {
    
    tasksList;
    @api recordId;

    @wire(projectTaskList, { projectId : '$recordId'})
    projectTasks({ error, data }) {
        if (data) {
            var counter = 0;
            this.tasksList = data;
            for(var i = 0; i < 5; i++) {

                if(this.tasksList[i].Completed__c == true) {

                    if(this.tasksList[i].Type__c == 'New Task') {
                        this.template.querySelector('.new').className = 'slds-path__item slds-is-complete';
                        counter++;
                    } else if(this.tasksList[i].Type__c == 'Planning Phase') {
                        this.template.querySelector('.planning').className = 'slds-path__item slds-is-complete';
                        counter++;
                    } else if(this.tasksList[i].Type__c == 'Construction Work') {
                        this.template.querySelector('.construction').className = 'slds-path__item slds-is-complete';
                        counter++;
                    } else if(this.tasksList[i].Type__c == 'Completion Step') {
                        this.template.querySelector('.deployment').className = 'slds-path__item slds-is-complete';
                        counter++;
                    } else if(this.tasksList[i].Type__c == 'Contract End') {
                        this.template.querySelector('.signoff').className = 'slds-path__item slds-is-complete';
                        counter++;
                    }
                }
            }
            switch(this.tasksList[counter].Type__c) {
                case 'New Task' : {
                    this.template.querySelector('.new').className = 'slds-path__item  slds-is-current slds-is-active';
                    break;
                } case 'Planning Phase' : {
                    this.template.querySelector('.planning').className = 'slds-path__item  slds-is-current slds-is-active';
                    break;
                } case 'Construction Work' : {
                    this.template.querySelector('.construction').className = 'slds-path__item  slds-is-current slds-is-active';
                    break;
                } case 'Completion Step' : {
                    this.template.querySelector('.deployment').className = 'slds-path__item  slds-is-current slds-is-active';
                    break;
                } case 'Contract End' : {
                    this.template.querySelector('.signoff').className = 'slds-path__item  slds-is-current slds-is-active';
                    break;
                }
            }
            counter = 0;
        } 
    }

}