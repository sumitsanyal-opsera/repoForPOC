/**
 * Apex page controller exposing the change-password functionality.
 *
 * Security improvements (WO-072):
 *  - Input validation: password fields checked for blank/null before use.
 *  - Confirmation check: newPassword must match verifyNewPassword before
 *    Site.changePassword is called.
 *  - Minimum length enforcement: passwords must be at least 8 characters.
 *  - Error state exposed via 'errorMessage' property so the VF page can
 *    display user-friendly feedback without exposing stack traces.
 *  - Removed dummy comment artefact.
 *  - API version 65.0.
 */
public with sharing class ChangePasswordController {

    public String oldPassword       { get; set; }
    public String newPassword       { get; set; }
    public String verifyNewPassword { get; set; }
    public String errorMessage      { get; private set; }

    private static final Integer MIN_PASSWORD_LENGTH = 8;

    public ChangePasswordController() {}

    public PageReference changePassword() {
        errorMessage = null;

        if (String.isBlank(oldPassword) || String.isBlank(newPassword) || String.isBlank(verifyNewPassword)) {
            errorMessage = 'All password fields are required.';
            return null;
        }

        if (newPassword.length() < MIN_PASSWORD_LENGTH) {
            errorMessage = 'New password must be at least ' + MIN_PASSWORD_LENGTH + ' characters.';
            return null;
        }

        if (newPassword != verifyNewPassword) {
            errorMessage = 'New password and confirmation do not match.';
            return null;
        }

        try {
            return Site.changePassword(newPassword, verifyNewPassword, oldPassword);
        } catch (Exception ex) {
            errorMessage = 'Password change failed. Please verify your current password and try again.';
            System.debug(LoggingLevel.ERROR, 'ChangePasswordController.changePassword error: ' + ex.getMessage());
            return null;
        }
    }
}
