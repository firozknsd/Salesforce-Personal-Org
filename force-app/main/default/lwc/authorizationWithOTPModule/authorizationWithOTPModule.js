import { LightningElement, track } from 'lwc';
import  sendOTP from '@salesforce/apex/AuthorizationWithOTPModuleController.sendOTP';
import  otpVerifier from '@salesforce/apex/AuthorizationWithOTPModuleController.otpVerifier';


export default class AuthorizationWithOTPModule extends LightningElement {
    @track emailValue;
    @track otpValue;
    @track showVerScr = false;
    @track showInfo = false;
    @track showOtpErr = false;
    @track showEmailErr = false;
    @track conData;

    @track timeVal = '0:0:0:0';
    timeIntervalInstance;
    totalMilliseconds = 0;
    @track showTimer = false;


    conInfoCol = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' }
    ];

    handleSendOTP() {

        this.timeVal = '0:0:0:0';
        this.totalMilliseconds = 0;

        this.emailValue = this.template.querySelector('.emailVal').value;

        if(this.emailValue != null) {
            let emails = [];            
            emails.push(this.emailValue);
            
            console.log('emails :',emails);
            
            sendOTP({emailsList : emails}).then(result => {
                if(result) {
                    console.log('result : ',result);
                    this.showVerScr = true;
                    this.showTimer = true;
                } else {
                    this.showEmailErr = true;
                }
            })

            
            var parentThis = this;

            // Run timer code in every 100 milliseconds
            this.timeIntervalInstance = setInterval(function() {

                // Time calculations for hours, minutes, seconds and milliseconds
                //var hours = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((parentThis.totalMilliseconds % (1000 * 60)) / 1000);
                //var milliseconds = Math.floor((parentThis.totalMilliseconds % (1000)));
                
                // Output the result in the timeVal variable
                parentThis.timeVal = minutes + ":" + seconds;   
                
                parentThis.totalMilliseconds += 100;
            }, 100);
            

        } else {
            this.showEmailErr = true;
        }
    }
    handleVerifyOTP() {
        console.log('otpValue :');
        this.otpValue = this.template.querySelector('.otpVal').value;
        otpVerifier({otp : this.otpValue , email : this.emailValue}).then(result => {
            
            if(result) {
                console.log('result :',result);
                this.conData = result;
                this.showInfo = true;
                this.showTimer = false;
            } else {
                this.showOtpErr = true;
            }
        })
        console.log('otpValue :',this.otpValue);
    }
    handleEraseErr() {
        this.showEmailErr = false;
        this.showOtpErr = false;
    }
}