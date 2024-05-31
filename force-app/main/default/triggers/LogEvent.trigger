trigger LogEvent on Log__e(after insert) {
    LogEvents.onAfterInsert();
}