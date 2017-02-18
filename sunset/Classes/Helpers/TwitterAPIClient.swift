import Foundation
import TwitterKit
import RealmSwift

class TwitterAPIClient {
    
    let realm: Realm = try! Realm()

    func savePosts() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        self.fetchUserTimeLine(tweets: {
            tws in
            for tw in tws {
                let tweet: Tweet = Tweet()
                tweet.content = tw.text
                tweet.created_at = formatter.string(from: tw.createdAt)
                tweet.user_id = tw.author.screenName
                tweet.tweet_id = tw.tweetID

                do {
                    try self.realm.write() {
                        self.realm.add(tweet, update: true)
                    }
                } catch {
                    let error = error as NSError
                    print("error: \(error), \(error.userInfo)")
                }
            }
        })
    }

    private func fetchUserTimeLine(tweets: @escaping ([TWTRTweet]) -> ()) {
        let client = TWTRAPIClient(userID:  Twitter.sharedInstance().sessionStore.session()?.userID)

        var clientError: NSError?
        let endpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["include_rts": "false", "trim_user": "false", "count": "100"]
        let request = client.urlRequest(withMethod: "GET", url: endpoint, parameters: params, error: &clientError)

        client.sendTwitterRequest(request, completion: {
            response, data, err in
            if (err == nil) {
                let json: AnyObject? = try! JSONSerialization.jsonObject(with: data!) as AnyObject?
                if let jsonArray = json as? NSArray {
                    tweets(TWTRTweet.tweets(withJSONArray: jsonArray as [AnyObject]) as! [TWTRTweet])
                }
            } else {
                print(err!)
            }
        })
    }
}
