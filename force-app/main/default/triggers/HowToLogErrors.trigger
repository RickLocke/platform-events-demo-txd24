trigger HowToLogErrors on Case (before insert) {
    try {
        List<Case> newCases = (List<Case>) Trigger.new;
        for (Case c : newCases) {
            // do something here
        }
    // catch if it failes
    } catch (Exception ex) {
        // Log the error
        Logger.log(
            'An error occurred in the BadTrigger trigger', // Error message
            'ERROR', // Error "LEVEL"
            ex // Exception
        );
    }
}