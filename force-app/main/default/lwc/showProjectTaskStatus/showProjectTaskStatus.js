import { LightningElement, api, wire } from 'lwc';

export default class ShowProjectTaskStatus extends LightningElement {
    
    @api recordId;
    projectTaskList;

    newStatus;
    planningStatus;
    constructionStatus;
    deploymentStatus;
    signoffStatus;

    constructor() {
        super();
        this.changeProjectStatus();
    }
    changeProjectStatus() {
        projectTaskList({projectId : this.recordId}).then(result => {
            if(result) {
                this.projectTaskList = result;
                //console.log('$$ '+ this.projectTaskList);
            }
        })
    }
}