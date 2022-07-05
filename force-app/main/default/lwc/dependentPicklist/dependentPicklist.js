import { LightningElement } from 'lwc';

export default class DependentPicklist extends LightningElement {

    stateOptions;
    cityOptions;
    pinOptions;
    country = "";
    state = "";
    city = "";
    pin = "";

    data = [
        {
            "India" : {
                "Rajasthan" : {
                    "Ajmer" : "305601",
                    "Jaipur" : "302012",
                    "Kota" : "306055"
                },
                "Mp" : {
                    "Bhopal" : "305601",
                    "Neemuch" : "302012",
                    "Ujjain" : "306055"
                }
            },
            "Usa" : {
                "Washington dc" : {
                    "Alexandria" : "305601",
                    "Virginia" : "302012",
                    "Georgetown" : "306055"
                },
                "Hawaii" : {
                    "East Honolulu" : "305601",
                    "Honolulu" : "302012",
                    "Pearl City" : "306055"
                }
            },
            "Uae" : {
                "Dubai" : {
                    "Al Faqa" : "305601",
                    "Al Halah" : "302012",
                    "Al Hamriyah" : "306055"
                },
                "Sharjah" : {
                    "Malilha" : "305601",
                    "Al Dhaid" : "302012",
                    "Al Badayer" : "306055"
                }
            }
        }
    ];
    
    get countryOptions() {
        var countryOptions = [];
        for(var country in this.data[0]) {
            var obj = {};
            obj.label = country;
            obj.value = country;
            countryOptions.push(obj);
        }
        return countryOptions;
    }
    handleSelectCombobox(event) {
        if(event.target.name == "Country") {
            this.stateOptions = [];
            this.cityOptions = [];
            this.pin = '';
            this.country = event.target.value;
             
            for(var stateValue in this.data[0][event.target.value]) {
                var obj = {};
                obj.label = stateValue;
                obj.value = stateValue;
                this.stateOptions.push(obj);
            }

        } else if(event.target.name == "State") {
            
            this.pin = '';
            this.cityOptions = [];
            this.state = event.target.value;
             
            for(var cityValue in this.data[0][this.country][event.target.value]) {
                var obj = {};
                obj.label = cityValue;
                obj.value = this.data[0][this.country][this.state][cityValue];
                this.cityOptions.push(obj);
            }

        } else if(event.target.name == "City") {
            this.pin = event.target.value;
        }
    }
    
}