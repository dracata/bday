@isTest public with sharing class birthdaysTodayTest {
    //Test for the birthdaysToday method.
    @isTest public static void testbirthdaysToday()
    {	
        //The current date is recorded for use as a variable.
        Date d = system.today();
        //The contactList is created to insert our sample contacts.
        List<Contact> contactList = new List<Contact>();
        //The loop below creates 6 sample contacts whose birthdays are today.
        for(integer i = 0; i < 6; i++)
        {
            Contact c = new Contact();
            c.LastName = 'Test';
            c.FirstName = 'Test';
            c.Birthdate = d;
            contactList.add(c);
        }
        //The list of contacts is inserted into the database.
		insert contactList;
        //The test is run, using the returnTodayContact method. 
        test.startTest();
        List<Contact> birthdayList = bday.birthdaysToday.returnTodayContact();
        test.stopTest();
        //With this test, we would expect 5 contacts whose birthdays are today to be returned.
        system.assertEquals(5,birthdayList.size());   
        system.assertNotEquals(1,birthdayList.size());
    }
}