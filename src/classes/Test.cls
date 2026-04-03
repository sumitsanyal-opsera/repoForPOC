public class Test 
{
    public static void myMethod()
    {
        List<Account> accList=[Select Name,NumberOfEmployees from Account];
        for(Integer i=0;i<accList.size();i++)
        {
            System.debug(accList[i].NumberOfEmployees);
        }
        for(Account a:accList)
        {
            System.debug('**********************Account Name='+a.name+'*********Number of Employees***********'+a.NumberOfEmployees);
        }
    }

}