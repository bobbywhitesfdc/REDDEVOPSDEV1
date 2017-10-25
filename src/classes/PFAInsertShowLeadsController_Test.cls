@isTest
public class PFAInsertShowLeadsController_Test {
    public static final Integer BULK_COUNT=150;
    
    public static testMethod void testBadLead() {
        Test.setCurrentPage(Page.PFAInsertShowLeads);
        ApexPages.StandardController stdController = new ApexPages.StandardController(new Lead());
        PFAInsertShowLeadsController controller = new PFAInsertShowLeadsController(stdController);
        System.Assert(controller!=null,'Must get here without exception');
        
        ApexPages.StandardSetController setCon = controller.setCon;
        System.Assert(setCon!=null,'Must have a valid set controller');
        
        List<Lead> myLeads = controller.getleads();
        System.Assert(myLeads!=null && !myLeads.isEmpty(),'Expected some leads!');
        
        System.AssertEquals(controller.saveandnew(),null,'Expected null PageRef on Save');
        System.AssertEquals(ApexPages.getMessages().size(),1,'Should have been a failure message');
    }
    
    public static testMethod void testGoodLead() {
        Lead myNewLead = new Lead(FirstName='Sally',LastName='LeadMeister');

        Test.setCurrentPage(Page.PFAInsertShowLeads);
        ApexPages.StandardController stdController = new ApexPages.StandardController(myNewLead);
        PFAInsertShowLeadsController controller = new PFAInsertShowLeadsController(stdController);
        System.Assert(controller!=null,'Must get here without exception');
        
        ApexPages.StandardSetController setCon = controller.setCon;
        System.Assert(setCon!=null,'Must have a valid set controller');
        
        List<Lead> myLeads = controller.getleads();
        System.Assert(myLeads!=null && !myLeads.isEmpty(),'Expected some leads!');
        
        System.AssertEquals(controller.saveandnew(),null,'Expected null PageRef on Save');
        String msg = ApexPages.getMessages().isEmpty() ? 'No messages': ''+ ApexPages.getMessages()[0];
        System.AssertEquals(ApexPages.getMessages().size()
                            ,0
                            ,msg);
    }

    
    @testSetup
    private static void setup() {
        
        // Create some leads!
        List<Lead> testLeads = new List<Lead>();
        for(Integer i=0; i < BULK_COUNT; i++) {
            Lead current = new Lead(FirstName='Test'+i,LastName='Lead');
            testLeads.add(current);
        }
        insert testLeads; 
    }
}