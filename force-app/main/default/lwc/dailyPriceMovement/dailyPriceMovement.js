import { LightningElement, track, wire } from 'lwc';
import  getDailyPriceLMovement  from '@salesforce/apex/DailyPriceMovementController.getDailyPriceLMovement';

export default class DailyPriceMovement extends LightningElement {
    @track dailyPriceMovement = [];
    @track yesterdayClass;
    @track oneWeekAgoClass;
    @track monthsStartingClass;
    @track threeMonthsAgoClass;
    
    @wire(getDailyPriceLMovement)
    allDailyPriceMovements({ error, data }) {

        if(data) {
            this.dailyPriceMovement = JSON.parse(JSON.stringify(data));

            var yesterday;
            var oneWeekAgo;
            var monthStating;
            var threeMonthsAgo;

            for(var i=0; i<this.dailyPriceMovement.length; i++) {

                 this.dailyPriceMovement[i].yesterday = this.dailyPriceMovement[i].today - this.dailyPriceMovement[i].yesterday;
                 this.dailyPriceMovement[i].oneWeekAgo = this.dailyPriceMovement[i].today - this.dailyPriceMovement[i].oneWeekAgo;
                 this.dailyPriceMovement[i].monthStarting = this.dailyPriceMovement[i].today - this.dailyPriceMovement[i].monthStarting;
                 this.dailyPriceMovement[i].threeMonthsAgo = this.dailyPriceMovement[i].today - this.dailyPriceMovement[i].threeMonthsAgo;

                yesterday = this.dailyPriceMovement[i].yesterday;
                oneWeekAgo = this.dailyPriceMovement[i].oneWeekAgo;
                monthStating = this.dailyPriceMovement[i].monthStarting;
                threeMonthsAgo = this.dailyPriceMovement[i].threeMonthsAgo;

                console.log(i + ' Yeserday : ',this.dailyPriceMovement[i].yesterday);
                console.log(i + ' One week ago :  : ',this.dailyPriceMovement[i].oneWeekAgo);
                console.log(i + ' Month Starting : ',this.dailyPriceMovement[i].monthStarting);
                console.log(i + ' threeMonthsAgo : ',this.dailyPriceMovement[i].threeMonthsAgo);

                if(yesterday > 0) {
                    this.yesterdayClass = 'greenClass';
                } else if(yesterday < 0) {
                    this.yesterdayClass = 'redClass';
                } else {
                    this.yesterdayClass = 'yellowClass';
                }

                 if(oneWeekAgo > 0){
                    this.oneWeekAgoClass = 'greenClass';
                 }
                 else if(oneWeekAgo < 0) {
                   this.oneWeekAgoClass = 'redClass';
                }
                //else {
                //     this.oneWeekAgoClass = 'yellowClass';
                // }
                /*
                if(oneWeekAgo > 0) {
                    this.oneWeekAgoClass = 'greenClass';
                    console.log('oneWeekAgo greenClass', yesterday);
                }
                else if(oneWeekAgo < 0) {
                    this.oneWeekAgoClass = 'redClass';
                    console.log('oneWeekAgo redClass', yesterday);
                } 
                else if(oneWeekAgo == 0){
                    this.oneWeekAgoClass = 'yellowClass';
                    console.log('oneWeekAgo yellowClass', yesterday);
                }    
                
                // if(monthStating > 0) {
                //     this.monthsStartingClass = 'greenClass';
                // } 
                // if(monthStating < 0) {
                //     this.monthsStartingClass = 'redClass';
                // }
                // if(yesterday == 0) {
                //     this.monthsStartingClass = 'yellowClass';
                // }

                // if(threeMonthsAgo > 0) {
                //     this.threeMonthsAgoClass = 'greenClass';
                // } 
                // if(threeMonthsAgo < 0) {
                //     this.threeMonthsAgoClass = 'redClass';
                // } 
                // if(yesterday == 0) {
                //     this.threeMonthsAgoClass = 'yellowClass';
                // }
                */
            }
            
        } else {
            console.log('##', error);
        }
    }
}