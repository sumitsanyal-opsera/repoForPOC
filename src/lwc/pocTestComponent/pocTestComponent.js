import { LightningElement } from 'lwc';

export default class PocTestComponent extends LightningElement {
    name = '';
    showMessage = false;

    handleChange(event) {
        this.name = event.target.value;
    }

    handleClick() {
        this.showMessage = this.name && this.name.trim().length > 0;
    }
}
