@isTest public with sharing class birthdaysUpcomingTest {
    //Test for the birthdaysUpcoming method.
    @isTest public static void testbirthdaysUpcomingBothMonths()
    {	
        //Setting date-related variables for use when creating contacts.
        Date d = system.today();
        Date d1 = d.addDays(1);
        Date d2 = d.addMonths(1);
        //The contactList is created to insert our sample contacts.
        List<Contact> contactList = new List<Contact>();
        //The loops below create a mix of sample contacts with future birthdays this month and the next.
        for(integer i = 0; i < 3; i++){
            Contact c = new Contact();
            c.LastName = 'Test';
            c.FirstName = 'Test';
            c.Birthdate = d1;
            contactList.add(c);
        }
        for(integer i = 0; i < 3; i++){
            Contact c = new Contact();
            c.LastName = 'Test';
            c.FirstName = 'Test';
            c.Birthdate = d2;
            contactList.add(c);
        }
        //The list of contacts is inserted into the database.
        insert contactList;
        //The test is run, using the returnUpcomingContact method. 
        test.startTest();
        List<Contact> birthdayList = bday.birthdaysUpcoming.returnUpcomingContact();
        List<Contact> listof3 = new List<Contact>();
        List<Contact> listof2 = new List<Contact>();
     	for(contact c:birthdayList)
        {
            Integer mo1 = c.Birthdate.month();
            Integer mo2 = d1.month();
            Integer mo3 = d2.month();
            if(mo1 == mo2)
            {
                listof3.add(c);
            }
            
            if(mo1 == mo3){
                listof2.add(c);
            }
        }
        test.stopTest();
        //With this test, we would expect 3 contacts with upcoming birthdays this month, and 2 for next month to be returned.
        system.assertEquals(5,birthdayList.size());
        system.assertNotEquals(1,birthdayList.size());
        system.assertEquals(3,listof3.size());
        system.assertNotEquals(2,listof3.size());
        system.assertEquals(2,listof2.size());
        system.assertNotEquals(5,listof2.size());
}
    
    @isTest public static void testBirthdaysUpcomingMoreThanFive(){
        //Setting date-related variables for use when creating contacts.
        Date d = system.today();
        Date d1 = d.addDays(1);
        Date d2 = d.addMonths(1);
        //The contactList is created to insert our sample contacts.
        List<Contact> contactList = new List<Contact>();
		//The loop below creates 6 sample contacts with future birthdays this month.
        for(integer i = 0; i < 6; i++){
            Contact c = new Contact();
            c.LastName = 'Test';
            c.FirstName = 'Test';
            c.Birthdate = d1;
            contactList.add(c);
    }
        //The list of contacts is inserted into the database.
        insert contactList;
        //The test is run, using the returnUpcomingContact method.
        test.startTest();
        List<Contact> birthdayList = bday.birthdaysUpcoming.returnUpcomingContact();
        test.stopTest(); 
        //With this test, we would expect 5 contacts with upcoming birthdays this month to be returned and no others.
        system.assertEquals(5, birthdayList.size());
        system.assertNotEquals(4, birthdayList.size());
    }
}