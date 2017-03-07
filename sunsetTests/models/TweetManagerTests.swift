import XCTest
import RealmSwift

@testable import sunset

class TweetManagerTests: XCTestCase {
    
    let realm: Realm = try! Realm()
    let tweetManager: TweetManager = TweetManager()
    let tweet: Tweet = Tweet()
    
    override func setUp() {
        super.setUp()
        self.tweet.content = "平民なので申し訳なく鳥貴族に行かせていただきます"
        self.tweet.created_at = "2017-01-01"
        self.tweet.user_id = "sunset"
        self.tweet.tweet_id = "1"
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
        let oneTweet: [Tweet] = self.tweetManager.filter(date: "2017-01-01")
        XCTAssertEqual(oneTweet.count, 1)
        XCTAssertEqual(oneTweet[0].content, self.tweet.content)
        XCTAssertEqual(oneTweet[0].created_at, self.tweet.created_at)
        XCTAssertEqual(oneTweet[0].user_id, self.tweet.user_id)
        XCTAssertEqual(oneTweet[0].tweet_id, self.tweet.tweet_id)
        
        let zeroTweets: [Tweet] = self.tweetManager.filter(date: "2017-01-02")
        XCTAssertEqual(zeroTweets.count, 0)
    }
}
