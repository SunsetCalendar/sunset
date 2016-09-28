import XCTest
import Nimble
import OHHTTPStubs

@testable import sunset

class micropostTests: XCTestCase {

    var test_content = "Test Post"

    override func setUp() {
        super.setUp()

        stub(condition: isScheme("https") && isHost("asuforce.xyz") && isPath("/api/users/5") && isMethodGET()){ _ in
            return OHHTTPStubsResponse(
                jsonObject: ["feeds" : [["content" : "\(self.test_content)"]]],
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
