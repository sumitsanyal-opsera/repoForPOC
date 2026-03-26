@isTest
public class DummyPOCServiceTest {
    
    @isTest
    static void testGetGreeting_WithName() {
        String result = DummyPOCService.getGreeting('DevOps');
        System.assertEquals('Hello, DevOps!', result, 'Greeting with name failed');
    }
    
    @isTest
    static void testGetGreeting_WithoutName() {
        String result = DummyPOCService.getGreeting(null);
        System.assertEquals('Hello, Guest!', result, 'Greeting without name failed');
    }
    
    @isTest
    static void testAddNumbers_NormalCase() {
        Integer result = DummyPOCService.addNumbers(5, 10);
        System.assertEquals(15, result, 'Addition logic failed');
    }
    
    @isTest
    static void testAddNumbers_WithNulls() {
        Integer result = DummyPOCService.addNumbers(null, 5);
        System.assertEquals(5, result, 'Null handling failed');
    }
}