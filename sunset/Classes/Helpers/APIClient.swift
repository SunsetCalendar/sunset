import Foundation
import TwitterKit
import RealmSwift

class APIClient {
    
    let realm: Realm = try! Realm()

    func getHomeTimeLine(tweets: @escaping ([TWTRTweet]) -> (), error: @escaping (Error) -> ()) {
        let client = TWTRAPIClient(userID:  Twitter.sharedInstance().sessionStore.session()?.userID)
        
        var clientError: NSError?
        let endpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["include_rts": "false", "trim_user": "false"]
        let request = client.urlRequest(withMethod: "GET", url: endpoint, parameters: params, error: &clientError)

        client.sendTwitterRequest(request, completion: {
            response, data, err in
            if (err == nil) {
                let json: AnyObject? = try! JSONSerialization.jsonObject(with: data!) as AnyObject?
                //let json = JSON(data: data!)
                if let jsonArray = json as? NSArray {
                    tweets(TWTRTweet.tweets(withJSONArray: jsonArray as [AnyObject]) as! [TWTRTweet])
                }
            } else {
                error(err!)
            }
        })
        
    }
    
}
