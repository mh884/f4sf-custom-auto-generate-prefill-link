# :bulb: Dynamic Prefill with Salesforce Flow (BETA)

Currently, Formstack for Salesforce creates a trigger for each form when we enabled the Auto-Generate Prefill link.

This code will enable Admin to add Apex actions on Flow automation peer record-Triggered Flow on Object, and you will be able to generate the link for many Forms.

This code have 3 main parts.

### 1. FLOW
  
We would create one Flow for the object that you want to set the links.

Example in this code: FS_prefill_demo

You should change the object as your need. This is only one example which is for Account Object.

### 2. Custom Settings
  
Custom Settings Name: FSTriggerConfig

This custom settings will hold all the information of which Form and Field you want to use to generate the link for Prefill.

### 3. Custom Code
Class Name: FSCustomAutoGeneratePrefillLink

This code will get the Forms from the Custom Settings, and call Formstack For Salesforce Code which will generate the link and update the record for us.

## :arrow_down: install unmanaged package
Use the following link to install package into the org
[unmanged package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t8W000003FMx2)


## :computer: Steps to deploy this code into Scratch Org/Sandbox


### 1. Make sure you have an org setup in VSCode.

1.1. We need an org as default, it could be develop, scratch org or Sandbox.

### 2. Make sure your org has Formstack Installed

2.1. The code on this repo uses objects from Formstack for Salesforce, so you need to have it in the org.

### 3. Deploy this code to your org


## :wrench: How to use this code

### 1. Once you have deployed the code now it is time to setup the code to work.

### 2. Go to Formstack for Salesforce, create a Form for Account called "Form A".

2.1. It is a simple form, so leave the Account Name and Publish the Form.

2.2. Enable the Prefill.

### 3. Let's enable the Custom Auto-Generate Prefill

3.1. Setup >> Custom Settings >> Search for FSTriggerConfig >> Click on Manage

3.2. Click on New

3.2.1. Name: Form A

3.2.2. FieldApiName: WebSite

3.3.3. ObjectApiName: Account

3.3.4. Click on Save

### 4. Time to Test

4.1. Open the Hosted form Link from the Form that we created.

4.2. Do a Submission

4.3. Go to Submission Dashboard and check if the record is showing there.

4.3. Open the Record and check if the website is showing the link.

4.4. That is it! If you click on the link it should open the form and prefill the form.


# :mega: Things to keep in mind

1. This solution is linked with the Form name, so if the user changes the name you have to change the configuration.
1.1. You could change the code to use the Id instead of name, but that would fail when you test things in Sandbox and Push your code to Production because the ID of the Form will change.
2. The code coverage for the FSCustomAutoGeneratePrefillLink is 85%, and it is not well done because we are not testing if we are actually updating the records.
3. This was tested only with a few records.
4. There is a Flow on this code already for Account. This is just an example, you should apply that to your object.
5. You should Test your code and read the code that we have here.
6. You should be responsible for give maintenance on this code.
7. This code is just to help customers when they have too many triggers.
8. This is not an end solution for Formstack for Salesforce. Formstack for Salesforce will have a different solution for this.
9. We also have an option to generate the links using the [Salesforce Flow](https://sfapphelp.formstack.com/s/article/Generate-Forms-for-Salesforce-Prefill-URLs-using-Flow), which we would recommend to use over this code solution.

