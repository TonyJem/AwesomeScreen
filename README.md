# AwesomeScreen
Simple iOS App, done as test task project for learning purposes in 2023 November.

[Description](#description)

[Implementation](#implementation)

[Demonstration](#demonstration)

## Description:
This App fetches a list of Control Units from Mock AP (which imitatates Network requests and fetching of the Data) and manages these cotrol items later.

This Apps helps to User to get Units and navigate accross them. User can view, sort or filter items in the list by using provided sorting options and Search bar. Each Control Unit has a ID, name and status Badge (if any). It is not possible to navigate from Control Units list futher yet, due it is out of scope of the task.

#### This app handles the following actions:

  1. Display the list of Control Units, containing data, when it was successfully retrieved from API.
  
  2. Display the Emtpy Control Units view, when fetched data was retrieved with zero items inside it.
  
  3. Display the Loading Controls Failure view, when for some reason it was no possible to retrivie items from API.
  
  4. Show Loading View in between swithing views listed above.
  
  5. Search field available by clicking on Search button, enables User to search throught Conrol Units.
  
  6. Sort option available by clicking on Sort button.
<br>
<br>
<br>
  
## Implementation: 
There App currently consists of one Screen, which has 4 posible states. Below are displayed all of them:

1. The __Control Units View__ is a Prototype Table View and initially is a list displaying retrieved from disk data that was saved previuosly, since App was used last time. In that list each raw represents one single ToDo:

<img src="/AwesomeScreenSchots/00_controlUnits.png" width="33%"> 

There is possible to add new ToDo by pressing _Add_ button in top-right screen corner. After User has pressed _Add_ button, next will be initialized _second Table View_.
<br>
<br>

2. The __Emtpy Control Units View__ is a Static Table View, where each cell is in it's own section. There are three sections, where is essential to:
  * Add Basic Info
  * Set Due Date
  * Add some Notes for better ToDo's description
  
<img src="/AwesomeScreenSchots/01_emptyControls.png" width="33%">  

After adding all esential ToDo's information, in top-right screen's corner it will be enabled _Save_ button, which enables to save new ToDo to the list. When new ToDo was added and _Save_ button was pressed, App will come back to the first screen. Here again will be provided a.
<br>
<br>

3. The __Loading Controls Failure view__ is a Static Table View, where each cell is in it's own section. There are three sections, where is essential to:
  * Add Basic Info
  * Set Due Date
  * Add some Notes for better ToDo's description
  
<img src="/AwesomeScreenSchots/02_failedControls.png" width="33%">  

After adding all esential ToDo's information, in top-right screen's corner it will be enabled _Save_ button, which enables to save new ToDo to the list. When new ToDo was added and _Save_ button was pressed, App will come back to the first screen. Here again will be provided a 
<br>
<br>

4. The __Loading View__ is a Static Table View, where each cell is in it's own section. There are three sections, where is essential to:
  * Add Basic Info
  * Set Due Date
  * Add some Notes for better ToDo's description
  
https://github.com/TonyJem/AwesomeScreen/assets/62282734/f0d77167-6138-4c74-8337-92791435b4a6

After adding all esential ToDo's information, in top-right screen's corner it will be enabled _Save_ button, which enables to save new ToDo to the list. When new ToDo was added and _Save_ button was pressed, App will come back to the first screen. Here again will be provided a 
<br>
<br>

## Demonstration: 

1. Update Control Units list and switching between different states:

<img src="/AwesomeScreenSchots/00_Update-Demo.gif" width="33%">  
   
2. Search Control Units:

<img src="/AwesomeScreenSchots/01_Search.gif" width="33%"> 

3. Sort Control Units:

<img src="/AwesomeScreenSchots/02_Sort.gif" width="33%"> 


