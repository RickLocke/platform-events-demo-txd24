import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';

export default class PlatformEventToastNotification extends LightningElement {
    channelName = '/event/Log__e';
    subscription = {};

    connectedCallback() {
        this.handleSubscribe();
        this.registerErrorListener();
    }

    handleSubscribe() {
        const messageCallback = function(response) {
            const message = response.data.payload;
            this.showToast(message.Message__c, message.Level__c);
        }.bind(this);

        // Subscribe to the platform event channel
        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Successfully subscribed to channel: ', response.channel);
            this.subscription = response;
        });
    }

    showToast(message, level) {
        const toastEvent = new ShowToastEvent({
            title: 'New Log Event',
            message: message,
            variant: level.toLowerCase() // 'info', 'success', 'warning', 'error'
        });
        this.dispatchEvent(toastEvent);
    }

    disconnectedCallback() {
        // Unsubscribe from the platform event channel
        unsubscribe(this.subscription, response => {
            console.log('Successfully unsubscribed from channel: ', response);
        });
    }

    registerErrorListener() {
        // Callback invoked whenever an error occurs during subscription
        onError(error => {
            console.error('Received error from server: ', error);
        });
    }
}