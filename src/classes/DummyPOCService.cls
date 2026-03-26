public with sharing class DummyPOCService {
    
    // Sample method to return greeting message
    public static String getGreeting(String name) {
        if (String.isBlank(name)) {
            return 'Hello, Guest!';
        }
        return 'Hello, ' + name + '!';
    }
    
    // Sample method to calculate sum of two integers
    // New Dummy comment added
    public static Integer addNumbers(Integer a, Integer b) {
        a = (a == null) ? 0 : a;
        b = (b == null) ? 0 : b;
        return a + b;
    }
}
