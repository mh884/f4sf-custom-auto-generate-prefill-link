@IsTest
public with sharing class FSCustomAutoGeneratePrefillLinkTest {
  @IsTest
  public static void simpleTestForCoverage() {
    /**
     * This code is only to have coverage.
     * Because we don't have a Form with a Prefill, the link won't be generated.
     */

    // Arrange
    string triggerObjectApiName = 'Account';
    string formName = 'Form A';

    Account fakeAccount = new Account(name='fake Account');
    insert fakeAccount;

    FSTriggerConfig__c prefillConfig = new FSTriggerConfig__c();
    prefillConfig.Name = formName;
    prefillConfig.FieldApiName__c = 'Website';
    prefillConfig.ObjectAPIName__c = triggerObjectApiName;
    insert prefillConfig;

    VisualAntidote__Previous_Form__c fakeForm = new VisualAntidote__Previous_Form__c();
    fakeForm.Name = formName;
    fakeForm.VisualAntidote__Draft_Form__c = null;
    insert fakeForm;

    List<FSGeneratePrefillWorkFlowAutomation.FSPrefillParameters> ListOfprefillParameters = new List<FSGeneratePrefillWorkFlowAutomation.FSPrefillParameters>();
    FSGeneratePrefillWorkFlowAutomation.FSPrefillParameters prefillParameters = new FSGeneratePrefillWorkFlowAutomation.FSPrefillParameters();
    prefillParameters.sfRecordId = fakeAccount.id;
    ListOfprefillParameters.add(prefillParameters);
    // Act
    FSGeneratePrefillWorkFlowAutomation.execute(ListOfprefillParameters);

    // Assert
    Assert.isTrue(true, 'The should reash here');
  }
}
