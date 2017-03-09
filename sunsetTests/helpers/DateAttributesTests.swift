import XCTest
import Foundation
import RealmSwift

@testable import sunset

class DateAttributesTests: XCTestCase {
    
    let realm: Realm = try! Realm()
    let dateAttributes: DateAttributes = DateAttributes()
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func setUp() {
        super.setUp()
        let tweet: Tweet = Tweet()
        tweet.content = "平民なので申し訳なく鳥貴族に行かせていただきます"
        tweet.created_at = "2017-01-01"
        tweet.user_id = "sunset"
        tweet.tweet_id = "1"
        try! self.realm.write {
            self.realm.add(tweet, update: true)
        }
        // appDelegate 経由で年月を取得しているので, テストデータとして入れておく
        appDelegate.targetDate = "2017-01"
    }
    
    override func tearDown() {
        super.tearDown()
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
    
    func testExistPosts() {
        XCTAssertTrue(dateAttributes.existPosts(dayLabel: "1"))
        XCTAssertFalse(dateAttributes.existPosts(dayLabel: "2"))
    }

    func testChoiceDaysColor() {
        XCTAssertEqual(dateAttributes.choiceDaysColor(row: 0), .red)
        XCTAssertEqual(dateAttributes.choiceDaysColor(row: 6), .blue)
        for i in 1...5 {
            XCTAssertEqual(dateAttributes.choiceDaysColor(row: i), .white)
        }
    }
}
