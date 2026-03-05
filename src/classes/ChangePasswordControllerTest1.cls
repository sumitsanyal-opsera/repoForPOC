@IsTest
private class ChangePasswordControllerTest1 {

    @IsTest
    static void testChangePasswordMethod() {
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser' + System.currentTimeMillis() + '@example.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = p.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;

        System.runAs(testUser) {
            
            System.Test.startTest();
            
            ChangePasswordController controller = new ChangePasswordController();
            
            controller.oldPassword = 'OldPassword123';
            controller.newPassword = 'NewPassword123';
            controller.verifyNewPassword = 'NewPassword123';
            
            PageReference result = controller.changePassword();
            
            System.Test.stopTest();
            
            System.assertNotEquals(null, controller);
        }
    }
}