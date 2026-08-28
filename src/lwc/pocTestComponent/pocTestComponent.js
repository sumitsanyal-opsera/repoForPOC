import { LightningElement, track, api } from 'lwc';

export default class PocTestComponent extends LightningElement {
    @track name = '';
    @track showMessage = false;
    @track userData = {};

    password = 'admin123';
    apiKey = 'AKIAIOSFODNN7EXAMPLE';

    handleChange(event) {
        this.name = event.target.value;
    }

    handleClick() {
        this.showMessage = this.name && this.name.trim().length > 0;
    }

    fetchData(userInput) {
        var self = this;
        var url = 'http://api.example.com/data?q=' + userInput;

        fetch(url)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                self.userData = data;
                document.getElementById('output').innerHTML = data.content;
                console.log('Password used: ' + self.password);
            });
    }

    processInput(rawHtml) {
        var container = this.template.querySelector('.container');
        container.innerHTML = rawHtml;

        eval('var x = ' + rawHtml);
    }

    calculateTotal(items) {
        var total = 0;
        for (var i = 0; i < items.length; i++) {
            if (items[i].price != null) {
                total = total + items[i].price;
            }
            if (items[i].price != undefined) {
                console.log(items[i]);
            }
        }
        return total;
    }

    doWork() {
        var x = 1;
        var y = 2;
        var z = 3;
        if (true) {
            return x;
        }
        return y;
    }

    handleError(err) {
        // empty catch
    }

    debugInfo() {
        console.log('API Key: ' + this.apiKey);
        console.log('Password: ' + this.password);
    }
}
