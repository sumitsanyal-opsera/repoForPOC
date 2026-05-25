/**
 * Test class for CommunitiesLoginController (WO-031).
 *
 * Validates:
 *  - sanitiseStartUrl: relative URL accepted, absolute/null rejected
 *  - sanitiseDisplayType: known values accepted, unknown values nulled
 *  - forwardToAuthPage: invoked without exception
 */
@IsTest
global with sharing class CommunitiesLoginControllerTest {

    // -------------------------------------------------------------------------
    // sanitiseStartUrl
    // -------------------------------------------------------------------------

    @IsTest
    static void testSanitiseStartUrl_RelativeUrlAccepted() {
        String result = CommunitiesLoginController.sanitiseStartUrl('/home');
        System.assertEquals('/home', result, 'Relative URL should pass through unchanged');
    }

    @IsTest
    static void testSanitiseStartUrl_AbsoluteUrlRejected() {
        String result = CommunitiesLoginController.sanitiseStartUrl('http://evil.com');
        System.assertEquals('/', result, 'Absolute URL should be replaced with root redirect');
    }

    @IsTest
    static void testSanitiseStartUrl_NullReturnsRoot() {
        System.assertEquals('/', CommunitiesLoginController.sanitiseStartUrl(null),
            'Null startUrl should return root');
    }

    @IsTest
    static void testSanitiseStartUrl_BlankReturnsRoot() {
        System.assertEquals('/', CommunitiesLoginController.sanitiseStartUrl('   '),
            'Blank startUrl should return root');
    }

    // -------------------------------------------------------------------------
    // sanitiseDisplayType
    // -------------------------------------------------------------------------

    @IsTest
    static void testSanitiseDisplayType_KnownValueAccepted() {
        System.assertEquals('page',   CommunitiesLoginController.sanitiseDisplayType('page'));
        System.assertEquals('popup',  CommunitiesLoginController.sanitiseDisplayType('popup'));
        System.assertEquals('touch',  CommunitiesLoginController.sanitiseDisplayType('touch'));
        System.assertEquals('mobile', CommunitiesLoginController.sanitiseDisplayType('mobile'));
    }

    @IsTest
    static void testSanitiseDisplayType_UnknownValueNulled() {
        System.assertEquals(null, CommunitiesLoginController.sanitiseDisplayType('iframe'),
            'Unknown display type should be nulled');
    }

    @IsTest
    static void testSanitiseDisplayType_NullInputReturnsNull() {
        System.assertEquals(null, CommunitiesLoginController.sanitiseDisplayType(null),
            'Null display type should return null');
    }

    // -------------------------------------------------------------------------
    // forwardToAuthPage (functional smoke test)
    // -------------------------------------------------------------------------

    @IsTest(SeeAllData=true)
    global static void testForwardToAuthPage_DoesNotThrow() {
        CommunitiesLoginController controller = new CommunitiesLoginController();
        PageReference result = controller.forwardToAuthPage();
        // Result is null outside a community context; we verify no exception is thrown
        System.assert(true, 'forwardToAuthPage should not throw an exception');
    }
}
