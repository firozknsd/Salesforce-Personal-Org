public class ProductInfoController {
    @AuraEnabled(cacheable=true)
    public static List<Product2> productSearch(String productCode) {
        return [SELECT Id, Name, Description, (SELECT Id FROM Attachments), (SELECT Id, UnitPrice FROM PricebookEntries) FROM Product2 WHERE ProductCode =: productCode];
        
    }
}