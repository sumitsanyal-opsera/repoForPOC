/*Code of Set
 * public class Tea{
    public static void orderTea(){
        Set<String> teaTypes = new Set <String>{'Black', 'White', 'Herbal'};
            system.debug(teaTypes);
        teaTypes.add('Green');
        teaTypes.add('Black');
        system.debug(teaTypes);
    }
}*/

//Code of Map

public class Tea{
public static String orderTea(){
    Map <String, String> teaTypes = new Map <String, String>();
    teaTypes.put('Black', 'Earthy');
    teaTypes.put('White', 'Sweet');
    teaTypes.put('Herbal', 'Sweet');
    String flavorProfile = teaTypes.get('Herbal');
    System.debug('The flavorProfile of Herbal is: ' + flavorProfile);
    return flavorProfile;
}
}