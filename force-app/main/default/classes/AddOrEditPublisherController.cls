public class AddOrEditPublisherController {
    public static List<Product> products;
    public AddOrEditPublisherController() {
        products = new List<Product>();
    }
    @AuraEnabled(cacheable=true)
    public static List<Product> addProduct(String name, String qty, Double prize) {
        Product product = new Product(name, qty, prize);
        products.add(product);
        return products;
    }
    public class Product {
        public String name;
        public String qty;
        public Double prize;
        public Product(String name, String qty, Double prize) {
            this.name = name;
            this.qty = qty;
            this.prize = prize;
        }
    }
}