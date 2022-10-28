@IsTest
public with sharing class FSCustomAutoGeneratePrefillLinkTest {
  @IsTest
  public static void simpleTestForCoverage() {
    /**
     * This code is only to have coverage.
     * Because we don't have a Form with a Prefill, the link won't be generated.
     */

    // Arrange
    string randomFakeId = 'a0ZDE00000G4qgoXXX';
    string triggerObjectApiName = 'Account';
    string formName = 'Form A';

    FSTriggerConfig__c prefillConfig = new FSTriggerConfig__c();
    prefillConfig.Name = formName;
    prefillConfig.FieldApiName__c = 'Website';
    prefillConfig.ObjectAPIName__c = triggerObjectApiName;
    insert prefillConfig;

    VisualAntidote__Previous_Form__c fakeForm = new VisualAntidote__Previous_Form__c();
    fakeForm.Name = formName;
    fakeForm.VisualAntidote__Draft_Form__c = null;
    insert fakeForm;

    // Act
    Test.startTest();
    FSCustomAutoGeneratePrefillLink customCode = new FSCustomAutoGeneratePrefillLink(
      triggerObjectApiName,
      new Set<Id>{ randomFakeId }
    );
    customCode.executeDynamicPrefill();
    Test.stopTest();

    // Assert
    string noErrorMessage = '';
    System.assertEquals(
      noErrorMessage,
      customCode.errorMessage,
      'We should have no error message.'
    );
  }
}
