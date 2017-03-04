import XCTest
import RealmSwift

@testable import sunset

class TweetManagerTEsts: XCTestCase {
    
    let realm: Realm = try! Realm()
    let tweetManager: TweetManager = TweetManager()
    
    override func setUp() {
        super.setUp()
        let tweet: Tweet = Tweet()
        tweet.content = "平民なので申し訳なく鳥貴族に行かせていただきます"
        tweet.created_at = "2017-01-01"
        tweet.user_id = "sunset"
        tweet.tweet_id = "1"
        try! self.realm.write() {
            self.realm.add(tweet)
        }
        
    }
    
    override func tearDown() {
        super.tearDown()
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
    
    func testFilter() {
        let oneTweet = self.tweetManager.filter(date: "2017-01-01")
        XCTAssertEqual(oneTweet.count, 1)
        
        let zeroTweets = self.tweetManager.filter(date: "2017-01-02")
        XCTAssertEqual(zeroTweets.count, 0)
    }
}
