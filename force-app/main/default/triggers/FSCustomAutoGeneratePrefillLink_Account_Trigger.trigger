trigger FSCustomAutoGeneratePrefillLink_Account_Trigger on Account(
  after insert
) {
  Boolean updateOnlyOnInsert = Trigger.isAfter && Trigger.isInsert;
  if (!updateOnlyOnInsert) {
    // If it is not insert we will not run the trigger.
    System.debug(
      LoggingLevel.Debug,
      '[FSCustomAutoGeneratePrefillLink_Account_Trigger] Ignoring Trigger because it is not after insert.'
    );
    return;
  }

  if (Test.isRunningTest()) {
    System.debug(
      LoggingLevel.Debug,
      '[FSCustomAutoGeneratePrefillLink_Account_Trigger] Ignoring Trigger because it is not insert.'
    );
    return;
  }

  Set<Id> listOfIds = Trigger.newMap.keySet();
  new FSCustomDynamicPrefill('Account', listOfIds).executeDynamicPrefill();
}
