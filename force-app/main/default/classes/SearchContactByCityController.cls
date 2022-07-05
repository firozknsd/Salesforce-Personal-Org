public class SearchContactByCityController {
    public SearchContactByCityController() {

    }
    @AuraEnabled
    public static void contactNamesList(Contact contactObj) {
        System.debug('Hello'+contactObj);
    }
}
