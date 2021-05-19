public with sharing class birthdaysToday {
    //Method to return a list of contacts whose birthdays are today.
    @AuraEnabled(cacheable=true)
    public static List<Contact> returnTodayContact(){
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
        //Iterate through list of contacts to select contacts with birthdays today.
        for(contact c:contactList)
        {
            if(c.birthdate != null){
            Date birthday = c.Birthdate;
			Integer month1 = birthday.month();
            Integer day1 = birthday.day();
            if(day1 == day)
            {
                if(month1 == month)
                {
                    displayList.add(c);
                        }
            }
            //The returned data is limited to 5 contacts for aesthetics.
            if(displayList.size() == 5)
            {
                break;
            }
        }
        }
        //The retrieved contacts are returned, making them visible to the LWC.
        	return displayList;   
        } 
        else {
            return null;
        }
    }
}