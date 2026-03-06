@isTest
public class SimpleCalculatorTest {

    @isTest
    static void testAddNumbers() {
        Integer result = SimpleCalculator.addNumbers(5, 10);
        System.assertEquals(15, result, 'Addition result should be 15');
    }

    @isTest
    static void testMultiplyNumbers() {
        Integer result = SimpleCalculator.multiplyNumbers(4, 5);
        System.assertEquals(20, result, 'Multiplication result should be 20');
    }
}