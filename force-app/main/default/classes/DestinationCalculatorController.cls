public class DestinationCalculatorController {
    public DestinationCalculatorController() {

    }
    @AuraEnabled
    public static Object getRouteInfo(String location, String destination) {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://ibird2-dev-ed.my.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9fe4g9fhX0E409DMxNirr79LlfXosxC1Nr8OOs4xo4jcvxn8NFSuxbhuGZlcefsFZjBhUCOPoGJbbcr7N&client_secret=AFDA0583F7BB33E77F0C62C617183251639BBB1C658B2D6A5B852D55087D2C24&username=isharatjaha@ibird.com&password=ibirds123');
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res = http.send(req);
        
        System.debug('Responce : '+res.getBody());

        Oauth oAuthObj = (Oauth)JSON.deserialize(res.getBody(), Oauth.class);
        if(oAuthObj.access_token != NULL) {
            
            HttpRequest reqForData = new HttpRequest();
                                    
            reqForData.setEndpoint('https://ibird2-dev-ed.my.salesforce.com/services/apexrest/getRouteCalculate/?from=' + location + '&to=' + destination);
            //reqForData.setEndpoint('https://ibird2-dev-ed.my.salesforce.com/services/apexrest/getRouteCalculate/a0A5g000000j4TW');
            reqForData.setMethod('POST');
            reqForData.setHeader('Content-Length', '0');
            reqForData.setHeader('Content-Type', 'application/json');
            reqForData.setHeader('Authorization', 'Bearer '+oAuthObj.access_token);
            Http httpForData = new Http();
            HttpResponse resForData = new HttpResponse();
            resForData = httpForData.send(reqForData);
            System.debug('Result : '+resForData.getBody());
            return resForData.getBody();
        }
        return NULL;
    }
    
    public class Oauth {
        public String access_token{get;set;}
        public String instance_url{get;set;}
        public String id{get;set;}
        public String token_type{get;set;}
        public String issued_at{get;set;}
        public String signature{get;set;}
    }
}