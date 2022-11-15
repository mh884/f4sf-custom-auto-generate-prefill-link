global with sharing class FSGeneratePrefillWorkFlowAutomation {
    @InvocableMethod(label='Formstack - Generate Prefill Link beta')
    global static void execute(list<FSPrefillParameters> pFSPrefillParameters) {

      id objectRecordId = Id.valueOf(pFSPrefillParameters[0].SFRecordId);
      string objectName = objectRecordId.getSObjectType().getDescribe().getName();
    
      set<Id> recordIds = new set<Id>();
    
      for (FSPrefillParameters objFSPrefillParameters : pFSPrefillParameters) 
      {
        recordIds.add(objFSPrefillParameters.sfRecordId);
      }

      new FSCustomAutoGeneratePrefillLink(objectName, recordIds).executeDynamicPrefill();
    }
  
    global class FSPrefillParameters {
      @InvocableVariable
      global string sfRecordId;
    }
  }
  
