public class Class1 {
   	public Integer num1;
    public Integer num2;
    public Integer num3;
    public Integer sum(Integer num1,Integer num2)
    {       
        num3=num1+num2;        
        System.debug('*****Sum is:*****'+num3);
       	return num3;
    }    
	public Integer sub(Integer num1,Integer num2)
    {
        num3=num1*num2;

        //Test comment
        System.debug('*****Product is:*****'+num3);
        return num3;
    
	}
}
