# AwesomeScreen
Simple iOS App, done as test task project for learning purposes in 2023 November.

[Description](#description)

[Implementation](#implementation)

[Demonstration](#demonstration)

## Description:
This App shows to User a list of Control Units fetched from Mock API (which imitates Network requests and responds) and manages these Units list later.

This Apps helps to User to retrieve Units and navigate accross them. User can view, sort or filter Units in the list by using provided Sorting options and Search bar. Each Control Unit has an ID, name and status Badge (if any status included). It is not possible to navigate from Control Units list futher yet, due it is currently done as just one-screen App, and navigation from this screen is out of scope of that task.

#### This app handles the following actions:

  1. Display the list of Control Units, containing data, when it was successfully retrieved from API.
  
  2. Display the Emtpy Control Units view, when fetched data was retrieved with zero items inside it.
  
  3. Display the Loading Controls Failure view, when for some reason it was no possible to retrivie items from API.
  
  4. Show Loading View while switching in between Screen states listed above.
  
  5. Search field is available by clicking on Search button, enables User to search throught Conrol Units.
  
  6. Sort option available by clicking on Sort button.
     
  7. In order to refresh the Control Units list is implemented an additional "Update" button, which is accesible from any state of main screen.
<br>
<br>
  
## Implementation: 
There App currently consists of one Screen, which has 4 posible states. Below are presented all of them:

1. The __Control Units state__ is a state when on the screen is displayed a list, which contains all Control Units:

<img src="/AwesomeScreenSchots/00_controlUnits.png" width="33%"> 

All Control Units initially are sorted by their ID. Each Control Unit's item has these fields: Image, ID, Name and Status badge (if any status except "ok" is included).
It has some logic to display Name is included: Ussually, when particular Control Unit does not have a status, it' Name title can be shown maximum in two lines, then if name text is longer - the title will be truncated. In case when Control Unit has some label, for name is available only one line of text and if name is too long - it will be truncated.

<br>
<br>

2. The __Emtpy Control Units state__ is a state when Contol Units list successfully loaded 0 control units:
  
<img src="/AwesomeScreenSchots/01_emptyControls.png" width="33%">  

It will be shown when Mock request went ok and respond was also ok, but there were no available items to fetch.
<br>
<br>

3. The __Loading Controls Failure state__ is a state when Contol Units list loading fails:
  
<img src="/AwesomeScreenSchots/02_failedControls.png" width="33%">  

It will be shown when Mock respond was returned with failure. This Failure view contains "Try Again" button, which when is tappped reloads Contol Units the list. 
<br>
<br>

4. The __Loading state__ is a state when Contol Units list is loading:
  
https://github.com/TonyJem/AwesomeScreen/assets/62282734/f0d77167-6138-4c74-8337-92791435b4a6

Showing Loader View while switching in between Screen states during the Control Units list items are fething from Mock API.
<br>
<br>

## Demonstration: 

1. Update Control Units list and switching between different states:

<img src="/AwesomeScreenSchots/00_Update-Demo.gif" width="33%">  
   
2. Search Control Units:

<img src="/AwesomeScreenSchots/01_Search.gif" width="33%"> 

3. Sort Control Units:

<img src="/AwesomeScreenSchots/02_Sort.gif" width="33%"> 


