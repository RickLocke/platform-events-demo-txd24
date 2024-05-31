@IsTest
public class LoggerTest {
    @IsTest
    public static void testLogWithoutException() {
        // Start test execution context
        Test.startTest();
        
        // Call Logger without exception
        Logger.log('Information message', 'INFO');

        // Deliver platform event messages and handle them
        // This line ensures that any platform event subscribers, such as triggers,
        // process the published events within this test context.
        Test.getEventBus().deliver();
        
        // Stop test execution context
        Test.stopTest();
        
        // Query for Debug_Log__c records to confirm they were created
        List<Debug_Log__c> debugLogs = [SELECT Id FROM Debug_Log__c];
        // Assert that exactly one Debug_Log__c record was created
        System.assertEquals(1, debugLogs.size(), 'There should be one Debug Log record');
    }
}