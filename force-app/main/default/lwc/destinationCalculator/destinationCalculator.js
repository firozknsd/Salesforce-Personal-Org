import { LightningElement } from 'lwc';
import MY_RESOURCE from "@salesforce/resourceUrl/myResource";
import getRouteInfo from '@salesforce/apex/DestinationCalculatorController.getRouteInfo';

export default class DestinationCalculator extends LightningElement {
    carLogo = MY_RESOURCE + '/images/car.png';
    trainLogo = MY_RESOURCE + '/images/Train.png';
    trailLogo = MY_RESOURCE + '/images/trail.png';
    bicycleLogo = MY_RESOURCE + '/images/bicycle.png';
    airplaneLogo = MY_RESOURCE + '/images/airplane.png';

    route = '';
    time;
    distance = 0;

    location;
    destination;

    handleCar() {
        this.getValues();
        this.fetchData();

        var val = this.distance/60;
        this.distance = val.toFixed(2);
        this.time = Math.floor(this.distance) +' h '+ ((this.distance * 100) % 100 ) + ' min';

        if(((this.distance * 100) % 100 ) > 60) {
            var min = (((this.distance * 100) % 100) - 60) + ' min';
            var hour = (Math.floor(this.distance) + 1) + ' h ';
            this.time = hour + min;
        }
    }
    handleTrain() {
        this.getValues();
        this.fetchData();
        
        var val = this.distance/80;
        this.distance = val.toFixed(2);
        this.time = Math.floor(this.distance) +' h '+ ((this.distance * 100) % 100 ) + ' min';

        if(((this.distance * 100) % 100 ) > 60) {
            var min = (((this.distance * 100) % 100) - 60) + ' min';
            var hour = (Math.floor(this.distance) + 1) + ' h ';
            this.time = hour + min;
        }
    }
    handleTrail() {
        this.getValues();
        this.fetchData();
        
        var val = this.distance/10;
        this.distance = val.toFixed(2);
        this.time = Math.floor(this.distance) +' h '+ ((this.distance * 100) % 100 ) + ' min';

        if(((this.distance * 100) % 100 ) > 60) {
            var min = (((this.distance * 100) % 100) - 60) + ' min';
            var hour = (Math.floor(this.distance) + 1) + ' h ';
            this.time = hour + min;
        }
    }
    handleBicycle() {
        this.getValues();
        this.fetchData();
        
        var val = this.distance/20;
        this.distance = val.toFixed(2);
        this.time = Math.floor(this.distance) +' h '+ ((this.distance * 100) % 100 ) + ' min';

        if(((this.distance * 100) % 100 ) > 60) {
            var min = (((this.distance * 100) % 100) - 60) + ' min';
            var hour = (Math.floor(this.distance) + 1) + ' h ';
            this.time = hour + min;
        }
    }
    handleAirplane() {
        this.getValues();
        this.fetchData();
        
        var val = this.distance/700;
        this.distance = val.toFixed(2);
        this.time = Math.floor(this.distance) +' h '+ ((this.distance * 100) % 100 ) + ' min';

        if(((this.distance * 100) % 100 ) > 60) {
            var min = (((this.distance * 100) % 100) - 60) + ' min';
            var hour = (Math.floor(this.distance) + 1) + ' h ';
            this.time = hour + min;
        }
    }
    getValues() {
        this.location = this.template.querySelector('.locationClass').value;
        this.destination = this.template.querySelector('.destinationClass').value;
    }
    fetchData() {
        getRouteInfo({ location : this.location, destination : this.destination }).then( result=> {
            if(result) {
                const parsedData = JSON.parse(result);
                this.route = 'via '+parsedData.route;
                this.distance = parsedData.distance;
            } else {
                this.route = 'Not Found';
                this.distance = 'Not Found';
            }
            
        }).catch(error => {
            console.log('%%%%');
            console.log(error);
        });
    }

}