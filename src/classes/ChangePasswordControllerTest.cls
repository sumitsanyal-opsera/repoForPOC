/**
 * Test class for ChangePasswordController (WO-044 / WO-072).
 *
 * Validates input validation, confirmation matching, minimum-length
 * enforcement, and the error-state property.
 */
@IsTest
public with sharing class ChangePasswordControllerTest {

    // -------------------------------------------------------------------------
    // Blank-field validation
    // -------------------------------------------------------------------------

    @IsTest
    static void testChangePassword_BlankOldPasswordSetsError() {
        ChangePasswordController ctrl = new ChangePasswordController();
        ctrl.oldPassword       = '';
        ctrl.newPassword       = 'NewPass123';
        ctrl.verifyNewPassword = 'NewPass123';

        PageReference result = ctrl.changePassword();

        System.assertEquals(null, result, 'Should return null on validation failure');
        System.assertNotEquals(null, ctrl.errorMessage, 'Error message should be set');
        System.assert(ctrl.errorMessage.contains('required'), ctrl.errorMessage);
    }

    @IsTest
    static void testChangePassword_BlankNewPasswordSetsError() {
        ChangePasswordController ctrl = new ChangePasswordController();
        ctrl.oldPassword       = 'OldPass123';
        ctrl.newPassword       = '';
        ctrl.verifyNewPassword = '';

        PageReference result = ctrl.changePassword();

        System.assertEquals(null, result, 'Should return null on validation failure');
        System.assertNotEquals(null, ctrl.errorMessage, 'Error message should be set');
    }

    // -------------------------------------------------------------------------
    // Minimum length enforcement
    // -------------------------------------------------------------------------

    @IsTest
    static void testChangePassword_ShortPasswordSetsError() {
        ChangePasswordController ctrl = new ChangePasswordController();
        ctrl.oldPassword       = 'OldPass123';
        ctrl.newPassword       = 'abc';
        ctrl.verifyNewPassword = 'abc';

        PageReference result = ctrl.changePassword();

        System.assertEquals(null, result, 'Should return null for short password');
        System.assert(ctrl.errorMessage.contains('characters'), ctrl.errorMessage);
    }

    // -------------------------------------------------------------------------
    // Confirmation mismatch
    // -------------------------------------------------------------------------

    @IsTest
    static void testChangePassword_MismatchedPasswordsSetsError() {
        ChangePasswordController ctrl = new ChangePasswordController();
        ctrl.oldPassword       = 'OldPass123';
        ctrl.newPassword       = 'NewPass123!';
        ctrl.verifyNewPassword = 'DifferentPass!';

        PageReference result = ctrl.changePassword();

        System.assertEquals(null, result, 'Should return null on confirmation mismatch');
        System.assert(ctrl.errorMessage.contains('match'), ctrl.errorMessage);
    }

    // -------------------------------------------------------------------------
    // Valid input path (Site.changePassword returns null in test context)
    // -------------------------------------------------------------------------

    @IsTest(SeeAllData=true)
    static void testChangePassword_ValidInputCallsSiteMethod() {
        ChangePasswordController ctrl = new ChangePasswordController();
        ctrl.oldPassword       = '123456';
        ctrl.newPassword       = 'NewSecure123!';
        ctrl.verifyNewPassword = 'NewSecure123!';

        Test.startTest();
        PageReference result = ctrl.changePassword();
        Test.stopTest();

        // Site.changePassword returns null in test context; no exception expected
        System.assertEquals(null, result, 'Site.changePassword returns null in test context');
    }

    // -------------------------------------------------------------------------
    // Error message initially null
    // -------------------------------------------------------------------------

    @IsTest
    static void testErrorMessage_InitiallyNull() {
        ChangePasswordController ctrl = new ChangePasswordController();
        System.assertEquals(null, ctrl.errorMessage, 'errorMessage should be null on instantiation');
    }
}
