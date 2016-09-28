import XCTest
import Nimble

@testable import sunset

class micropostTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetMicroposts() {

        waitUntil { done in
            Micropost.fetchMicroposts { microposts in
                XCTAssertEqual("SSL化できたよう", microposts[0].content)
                done()
            }
        }
    }
}
