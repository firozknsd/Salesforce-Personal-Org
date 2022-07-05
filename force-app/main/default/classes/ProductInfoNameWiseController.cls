public class ProductInfoNameWiseController {

    @AuraEnabled
    public static List<ProductInfomation> productSearch(String productName) {
        String singleUrl;
        List<Product2> productList = [SELECT Id, Name, Description, (SELECT Id FROM Attachments), (SELECT Id, UnitPrice FROM PricebookEntries) FROM Product2 WHERE Name LIKE : '%'+ productName +'%']; 

        List<ProductInfomation> productInformationList = new List<ProductInfomation>();
        Attachment[] attach = new List<Attachment>();
        List<String> image = new List<String>();
        for(Product2 product : productList) {
            attach = product.Attachments;
            singleUrl = '/servlet/servlet.FileDownload?file='+product.Attachments[0].Id;
            for(Attachment att : attach) {
               image.add('/servlet/servlet.FileDownload?file='+att.Id);
            }
            ProductInfomation obj = new ProductInfomation(product.Id, singleUrl, image, product.PricebookEntries[0].UnitPrice,product);
            productInformationList.add(obj);
        }
        System.debug('Data : '+productInformationList);
        return productInformationList;
    }
    public class ProductInfomation {
        @AuraEnabled
        public Id id;
        @AuraEnabled
        public String singleUrl ;
        @AuraEnabled
        public String[] image;
        @AuraEnabled
        public Decimal price;
        @AuraEnabled
        public Product2 product;
        
        public ProductInfomation(Id id, String singleUrl, String[] image, Decimal price, Product2 product) {
            this.id = id;
            this.singleUrl = singleUrl;
            this.image = image;
            this.price = price;
            this.product = product; 
        }
    }
}