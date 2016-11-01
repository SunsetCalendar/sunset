import XCTest
import Nimble
import OHHTTPStubs

@testable import sunset

class micropostTests: XCTestCase {

    let tweet_id    = "1"
    let text = "Test Post"
    let created_at = "Wed Aug 29 17:12:58 +0000 2012"
    let screen_name = "TestUser"
    
    override func setUp() {
        super.setUp()

        stub(condition: isScheme("https") && isHost("api.twitter.com") && isPath("/1.1/statuses/user_timeline.json") && isMethodGET()){ _ in
            let json = ["text": self.text, "id_str": self.tweet_id, "created_at": self.created_at, "screen_name": self.screen_name] as [String : Any]
            

            return OHHTTPStubsResponse(
                jsonObject: json,
                statusCode: 200,
                headers: nil
            )
        }
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
}
