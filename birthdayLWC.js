//Mandatory component of all LWC JS.
import { LightningElement, track, wire } from "lwc";
//Importing the Apex methods from the classes used to perform SOQL and identify contacts by birthdate.
import returnTodayContact from "@salesforce/apex/bday.birthdaysToday.returnTodayContact";
import returnUpcomingContact from "@salesforce/apex/bday.birthdaysUpcoming.returnUpcomingContact";
//Defining columns for the lightning-datatable part of html.
const columns = [
  //Attributes for the first column, which contains the Contact page hyperlink.
  {
    label: "Name",
    //This formula custom field contains the URL for each contact's respective page url.
    fieldName: "bday__Page_URL__c",
    type: "url",
    //The column needs to display the Name of the contact record, indicated below.
    typeAttributes: {
      label: {
        fieldName: "Name"
      },
      //Target is set to _blank so that clicking the name opens up a new tab with their contact page.
      target: "_blank",
      tooltip: ""
    },
    hideDefaultActions: true
  },
  //Attributes for the second column, which contains the Birthday field.
  {
    label: "Birthday",
    fieldName: "bday__Shortened_Birthdate__c",
    type: "text",
    hideDefaultActions: true
  }
];

export default class BirthdayLWC extends LightningElement {
  //Setting the columns value within our LWC.
  columns = columns;
  //Settings below used to interpret data coming in from Salesforce.
  @wire(returnTodayContact) today;
  @wire(returnUpcomingContact) upcoming;
}
