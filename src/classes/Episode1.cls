/**
 * Author: Sumit
 * Date	 : 22 May
 * 
 **/
public class Episode1 {
    
    public void demoDataType(){
        Integer intEmployeeNumber=10;
        Decimal dblAge=23.5;
        String strHello='Hello World !!!!!!!';
        
        System.debug(intEmployeeNumber);
        System.debug(dblAge);
        System.debug(strHello);
    }
    
    public enum Season{Summer,Winter,Spring}
    
    public void demoList(){        
        List<String> colors=new List<String>{'Green','Yellow','Green'};
        List<String> moreColors=new List<String>();
        moreColors.add('Red');
        moreColors.add('Blue');        
        System.debug(colors);
        System.debug(moreColors);
    }

}