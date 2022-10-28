public with sharing class FSCustomAutoGeneratePrefillLink {
  private string currentObjectAPIName;
  private Map<string, TriggerPrefillConfig> listOfPrefillConfig;
  private List<Id> listOfNewIds;

  public FSCustomAutoGeneratePrefillLink(
    string pCurrentObjectApiName,
    Set<Id> pListOfIds
  ) {
    this.currentObjectAPIName = pCurrentObjectApiName;
    this.listOfPrefillConfig = new Map<string, TriggerPrefillConfig>();
    this.listOfNewIds = new List<Id>(pListOfIds);
  }

  public void executeDynamicPrefill() {
    /**
     * 1. Load Trigger Prefill Config
     * 1.1. Get Trigger Config from Custom Settings.
     * 1.2. Map to a class which holds all the info.
     * 1.3. Load all Forms Config from config into the Trigger Config class.
     * 2. Execute the Prefill Generator Link logic for each Form.
     */

    try {
      loadPrefillConfig();

      for (
        TriggerPrefillConfig fiPrefillConfig : this.listOfPrefillConfig.values()
      ) {
        log(
          'Starting Generating Link for[' +
          fiPrefillConfig.formName +
          '] FieldAPIName[' +
          fiPrefillConfig.urlFieldAPIName +
          '] Total of Records to Update[' +
          this.listOfNewIds.size() +
          ']'
        );
        FastFormsUtilities.DoUpdateRecords(
          this.currentObjectAPIName,
          fiPrefillConfig.urlFieldAPIName,
          fiPrefillConfig.formId,
          this.listOfNewIds,
          null
        );
      }
    } catch (CustomPrefillException ex) {
      log(ex.getMessage());
    } catch (Exception ex) {
      System.debug(
        LoggingLevel.ERROR,
        '[FSCustomAutoGeneratePrefillLink] Error unexpected! Error to generate Prefill Link for Object[' +
        this.currentObjectAPIName +
        '] ExMessage[' +
        ex.getMessage() +
        ']'
      );
    }
  }

  private void log(string pText) {
    System.debug(
      LoggingLevel.DEBUG,
      '[FSCustomAutoGeneratePrefillLink]' + pText
    );
  }

  private void loadPrefillConfig() {
    this.loadListOfTriggerPrefillConfig();
    this.mapFormsWithPrefillConfig();
  }

  private void mapFormsWithPrefillConfig() {
    List<Previous_Form__c> listOfForms = getListOfFormDraftFormIdsByListOfFormNames(
      this.listOfPrefillConfig.keySet()
    );
    if (listOfForms.size() == 0) {
      throw new CustomPrefillException(
        'No Form found with the names in Custom Settings.'
      );
    }

    for (Previous_Form__c fiForm : listOfForms) {
      TriggerPrefillConfig triggerConfig = listOfPrefillConfig.get(fiForm.Name);
      triggerConfig.formId = fiForm.Id;
    }
  }

  private List<Previous_Form__c> getListOfFormDraftFormIdsByListOfFormNames(
    Set<string> pListOfFormNames
  ) {
    return [
      SELECT ID, Name
      FROM Previous_Form__c
      WHERE Draft_Form__c = NULL AND Name IN :pListOfFormNames
    ];
  }

  private void loadListOfTriggerPrefillConfig() {
    List<FSTriggerConfig__c> listOfTriggerConfig = getPrefillConfigurationByFormApiName(
      this.currentObjectAPIName
    );
    if (listOfTriggerConfig.size() == 0) {
      throw new CustomPrefillException(
        'No Trigger Configuration in Custom Settings.'
      );
    }

    for (FSTriggerConfig__c fiTriggerConfig : listOfTriggerConfig) {
      TriggerPrefillConfig newTrigConfig = new TriggerPrefillConfig();
      newTrigConfig.formName = fiTriggerConfig.Name;
      newTrigConfig.urlFieldAPIName = fiTriggerConfig.FieldApiName__c;

      this.listOfPrefillConfig.put(newTrigConfig.formName, newTrigConfig);
    }
  }

  private List<FSTriggerConfig__c> getPrefillConfigurationByFormApiName(
    string pObjectApiName
  ) {
    List<FSTriggerConfig__c> listOfFSTriggerPrefill = [
      SELECT FieldApiName__c, Name
      FROM FSTriggerConfig__c
      WHERE ObjectAPIName__c = :pObjectApiName
    ];
    return listOfFSTriggerPrefill;
  }

  private class TriggerPrefillConfig {
    public string formName;
    public Id formId;
    public string urlFieldAPIName;
  }

  public class CustomPrefillException extends Exception {
  }
}
