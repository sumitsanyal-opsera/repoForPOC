import { LightningElement } from 'lwc';

export default class FeatureTogglePoc extends LightningElement {
    isEnabled = false;

    handleToggle(event) {
        this.isEnabled = event.target.checked;
    }
}