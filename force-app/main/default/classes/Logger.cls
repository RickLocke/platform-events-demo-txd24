/**
 * Logger class publishes Log__e events for logging.
 * It logs messages with optional exception details.
 */
public class Logger {

    // Method to publish log events using a String for the logging level
    public static void log(String message, String level, Exception e) {
        Log__e logEvent = new Log__e(
            User_ID__c = UserInfo.getUserId(),
            Message__c = message,
            Level__c = level,
            Timestamp__c = DateTime.now().format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''),
            Body__c = e != null ? e.getMessage() : 'No exception',
            Stack_Trace__c = e != null ? e.getStackTraceString() : 'No stack trace'
        );

        Database.SaveResult sr = EventBus.publish(logEvent);
        System.debug('Log event published: ' + logEvent);
        System.debug('Log event SaveResult: ' + sr);
    }

    // Overloaded method
    public static void log(String message, String level) {
        log(message, level, null);
    }
}