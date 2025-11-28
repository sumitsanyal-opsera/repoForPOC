public class StringArrayTest {
    public static List<string> generateStringArray(Integer digit)
        
    {
        List<string> newlistarray = new List<string>();
        
        for (Integer i=0;i<digit;i++ )
        {
            
            newlistarray.add('Test'+i);
        }
        
        return newlistarray;
    }
}