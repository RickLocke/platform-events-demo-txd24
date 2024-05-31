/**
 * LogEvents class handles Log__e platform events.
 * It creates and inserts Debug_Log__c records and logs errors if they occur.
 */
public without sharing class LogEvents {
    /**
     * Platform events can be retried up to a maximum of 10 times, after this the platform event trigger
     * goes into an error state and no new records can be processed
     */
    private static final Integer MAX_TRIGGER_RETRIES = 10;

    // This method is called after a Log__e event is inserted
    public static void onAfterInsert() {
        // Check if the maximum number of retries has been reached
        if (EventBus.TriggerContext.currentContext().retries == MAX_TRIGGER_RETRIES) {
            System.debug('Maximum retries reached for processing platform events');
            insertDebugLogRecord('Maximum retries reached for processing platform events', null);
        } else {
            try {
                // Attempt to create debug log records
                createDebugLogRecords();
            } catch (Exception e) {
                // If an exception occurs, log the error
                System.debug('Exception in createDebugLogRecords: ' + e);
                insertDebugLogRecord('Exception in createDebugLogRecords.', e);
            }
        }
    }

    // This method creates debug log records from the platform events
    private static void createDebugLogRecords() {
        List<Debug_Log__c> debugLogs = new List<Debug_Log__c>();
        
        // Loop through each Log__e event and create a corresponding Debug_Log__c
        for (Log__e event : (List<Log__e>) Trigger.new) {
            Debug_Log__c log = new Debug_Log__c(
                Body__c = event.Body__c,
                Level__c = event.Level__c,
                Message__c = event.Message__c,
                Stack_Trace__c = event.Stack_Trace__c,
                Timestamp__c = event.Timestamp__c,
                User_ID__c = event.User_ID__c
            );
            debugLogs.add(log);
        }

        // Insert all created Debug_Log__c records
        if (!debugLogs.isEmpty()) {
            insert debugLogs;
        }
    }

    // This method inserts a single debug log record, typically used for errors
    private static void insertDebugLogRecord(String message, Exception e) {
        Debug_Log__c log = new Debug_Log__c(
            Body__c = message,
            Level__c = 'ERROR',
            Message__c = e != null ? e.getMessage() : message,
            Stack_Trace__c = e != null ? e.getStackTraceString() : null,
            Timestamp__c = DateTime.now().format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')
        );
        System.debug('Inserting single error log due to exception or max retries');
        insert log;
    }
}