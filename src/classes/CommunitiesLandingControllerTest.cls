/**
 * Test class for CommunitiesLandingController (WO-032).
 *
 * Validates:
 *  - forwardToStartPage returns a PageReference or null without throwing
 *  - Controller can be instantiated
 */
@IsTest
public with sharing class CommunitiesLandingControllerTest {

    @IsTest(SeeAllData=true)
    public static void testForwardToStartPage_DoesNotThrow() {
        CommunitiesLandingController controller = new CommunitiesLandingController();
        Test.startTest();
        PageReference pageRef = controller.forwardToStartPage();
        Test.stopTest();

        // In test context Network.communitiesLanding() returns null or empty
        if (pageRef != null) {
            String url = pageRef.getUrl();
            System.assert(url == null || String.isEmpty(url),
                'PageReference URL should be null or empty in test context');
        } else {
            System.assert(true, 'Null PageReference is acceptable in test context');
        }
    }

    @IsTest
    static void testControllerInstantiation() {
        CommunitiesLandingController controller = new CommunitiesLandingController();
        System.assertNotEquals(null, controller, 'Controller should be instantiated successfully');
    }
}
