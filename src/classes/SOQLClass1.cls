public class SOQLClass1 
{
    public static void myMethod(String str)
    {
        List<Contact> conList=[Select Name,Email from Contact where Name=:str];
    	System.debug(conList[0]);
    }

}