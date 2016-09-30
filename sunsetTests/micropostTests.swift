import XCTest
import Nimble
import OHHTTPStubs

@testable import sunset

class micropostTests: XCTestCase {

    var test_user_id    = 1
    var test_content    = "Test Post"
    var test_created_at = "2016-09-27T06:46:41.000Z"

    override func setUp() {
        super.setUp()

        stub(condition: isScheme("https") && isHost("asuforce.xyz") && isPath("/api/users/5") && isMethodGET()){ _ in
            let json = ["feeds" : [
                ["user_id": "\(self.test_user_id)", "content": "\(self.test_content)", "created_at": "\(self.test_created_at)"]
            ]]

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

    func testGetMicroposts() {

        waitUntil { done in
            Micropost.fetchMicroposts { microposts in
                XCTAssertEqual("\(self.test_content)", microposts[0].content)
                done()
            }
        }
    }
}
