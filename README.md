# Salesforce Platform Events: Texas Dreamin' 2024

This repository contains a Salesforce Apex demo illustrating the use of Platform Events for logging and error handling mechanisms. This was initially presented at Texas Dreamin' 2024.

## Overview

The demo includes a custom Platform Event (`Log__e`), a Debug Log SObject (`Debug_Log__c`), Apex triggers, a handler class, a logger class, and a Lightning Web Component (LWC) designed to handle and display debug information efficiently. This demo aims to provide Salesforce developers with a simple example of leveraging Platform Events for better error handling and debugging.

## Setup

1. **Deploy the Metadata**: Use the metadata files provided to deploy the custom Platform Event, Apex classes, triggers, and LWC to your Salesforce org.
2. **Test the Setup**: Execute the provided test classes to ensure everything is functioning correctly in your environment.

## Usage

### Logger Class

To use the logger in your Apex classes, simply call the logging methods from the `Logger` class. Here’s a quick example:

```java
Logger.log('This is an info log', 'INFO');
```

It also supports a third parameter that accepts an exception if you have one:

```java
Logger.log('An error occurred', 'ERROR', e);
```

This will create and publish a `Log__e` event, which the system will process and store as a `Debug_Log__c` record.

### Lightning Web Component

The LWC (`platformEventToastNotification`) is designed to subscribe to the `Log__e` Platform Event and display toast notifications.

To see it in action, ensure the LWC is deployed and added to a Lightning page. The component automatically subscribes to the Platform Event and displays notifications based on the events received.