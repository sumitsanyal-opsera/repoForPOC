@isTest
private class AnimalLocatorTest{
    @isTest static void AnimalLocatorMock1() {
        System.Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        string result = AnimalLocator.getAnimalNameById(3);
        String expectedResult = 'chicken';
        //Test comment for Apex test class

        System.assertEquals(result,expectedResult );
    }
}
