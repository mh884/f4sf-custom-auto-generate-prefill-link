global with sharing class ProcessBuilderGeneratePrefillBETA {
    @InvocableMethod(label='Formstack - Generate Prefill Link beta')
    global static void execute(list<ProcessBuilderPrefillParameters> processBuilderPrefillParameters) {

    id objectRecordId = Id.valueOf(processBuilderPrefillParameters[0].SFRecordId);
    string objectName = objectRecordId.getSObjectType().getDescribe().getName();
  
    set<Id> recordIds = new set<Id>();
  
    for (ProcessBuilderPrefillParameters objProcessBuilderPrefillParameters : processBuilderPrefillParameters) {
       recordIds.add(objProcessBuilderPrefillParameters.sfRecordId);
     }

      new FSCustomAutoGeneratePrefillLink(objectName, recordIds).executeDynamicPrefill();
    }
  
    global class ProcessBuilderPrefillParameters {
      @InvocableVariable
      global string sfRecordId;
    }
  }
  
