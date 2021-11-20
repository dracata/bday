public with sharing class birthdaysUpcoming {
    //Method to return a list of contacts whose birthdays are coming up soon.
	@AuraEnabled(cacheable=true)
    public static List<Contact> returnUpcomingContact(){
     //Check to ensure that all fields queried in this component are accessible to the user.
     if(Schema.SObjectType.Contact.fields.Name.isAccessible() &&
        Schema.SObjectType.Contact.fields.bday__Page_URL__c.isAccessible() && 
        Schema.SObjectType.Contact.fields.Birthdate.isAccessible() && 
        Schema.SObjectType.Contact.fields.bday__Shortened_Birthdate__c.isAccessible()){
        //Create list of all contacts, and another to store filtered data.
        List<Contact> contactList = [SELECT Name,bday__Page_URL__c,Birthdate,bday__Shortened_Birthdate__c FROM Contact ORDER BY bday__Shortened_Birthdate__c];
        List<Contact> displayList = new List<Contact>();
        //Create variables for the current day and month.
        Date currentDate = Date.today();
        Integer month = currentDate.month();
        Integer day = currentDate.day();
		//Iterate through list of contacts to select contacts with birthdays after today but within the end of the this month.
        for(contact c:contactList)
        {
            if(c.birthdate != null){
            Date birthday = c.Birthdate;
            //Setting the variables for the date boundaries for the "Upcoming Birthdays" section.
			Integer month1 = birthday.month();
            Integer month2 = month + 1;
            Integer day1 = birthday.day();
            //If their birthday is after today, and the month is the current month, add them to the list.
            if(day < day1)
            {
                if(month1 == month)
                {
                    displayList.add(c);
                        }
            }  
            //The returned data is limited to 100 contacts for aesthetics.
            if(displayList.size() == 100)
            {
                break;
            }
        }
        }
        //The initial data retrieved is sorted by Birthdate. Therefore, if there are 5+ contacts whose upcoming birthdays are the current month,
        //the returned data will only include contacts for the current month. If less than 5 are returned, more contacts are checked.
        if(displayList.size() < 5)
        {
            //Iterate through list of contacts to select contacts with birthdays next month.
            for(contact c:contactList){
            if(c.birthdate != null){
            Date birthday = c.Birthdate;
            system.debug(birthday);
			Integer month1 = birthday.month();
            Integer month2 = month + 1;
            system.debug(month1);
            Integer day1 = birthday.day();
            system.debug(day1);
            //Exception needs to be made for December since month values of 12 + 1 will not display January birthdays.
            if(month1 == month2 && month2 < 12)
                {
                    displayList.add(c);
                }
            //Simple conditional if statement to account for January birthdays showing during December.
            if(month == 12 && month1 == 1)
            {
                displayList.add(c);
            }
            //The returned data is limited to 100 contacts for aesthetics.
            if(displayList.size() == 100)
            {
                break;
            }
        }
        }
}
        //The retrieved contacts are returned, making them visible to the LWC.
        return displayList;
        } else {
            return null;
        }
}
}
