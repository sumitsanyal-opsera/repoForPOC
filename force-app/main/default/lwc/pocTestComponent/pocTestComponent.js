import { LightningElement, track } from 'lwc';

export default class PocTestComponent extends LightningElement {
    @track name = '';
    @track showMessage = false;

    handleChange(event) {
        this.name = event.target.value;
    }

    handleClick() {
        this.showMessage = this.name && this.name.trim().length > 0;
    }
}
