import { LightningElement } from 'lwc';

export default class GuitarTutorials extends LightningElement {
    bool=false;
    classNameVar;
    tempClassLoader='https://www.youtube.com/embed/';
    songLink;
    handleImageClick(event) {
        this.bool=true;
        this.classNameVar = event.target.className;
        
        if(this.classNameVar == 'BeliverClass') {
            this.songLink = this.tempClassLoader + 'jki2p78ppjQ' + '?rel=0' + '&autoplay=1';
        } else if(this.classNameVar == 'KatyuChukoClass') {
            this.songLink = this.tempClassLoader + 'VHOeMIRLerA' + '?rel=0' + '&autoplay=1';
        } else if(this.classNameVar == 'BekhayaliClass') {
            this.songLink = this.tempClassLoader + 'fhBYrqYU13w' + '?rel=0' + '&autoplay=1';
        } 
    }
}