@IsTest
public with sharing class LogEventsTest {
    @IsTest
    static void onAfterInsert_WithValidParams_CreatesDebugLogRecord() {
        Test.startTest();
        Log__e logEvent = new Log__e(
            Message__c = 'Message LogEvents_TEST',
            Body__c = 'Body LogEvents_TEST',
            Stack_Trace__c = 'Stack Trace LogEvents_TEST',
            Level__c = 'WARN'
        );
        Database.SaveResult sr = EventBus.publish(logEvent);
        Test.stopTest();

        System.assert(sr.isSuccess());

        Debug_Log__c debugLog = [
            SELECT Message__c, Body__c, Stack_Trace__c
            FROM Debug_Log__c
            LIMIT 1
        ];

        System.assertEquals(logEvent.Message__c, debugLog.Message__c);
        System.assertEquals(logEvent.Body__c, debugLog.Body__c);
        System.assertEquals(logEvent.Stack_Trace__c, debugLog.Stack_Trace__c);
    }
}