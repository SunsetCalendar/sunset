import XCTest

class webviewUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShowMicroposts() {
        let app = XCUIApplication()
        app.tables.staticTexts["プロトタイプ完成"].tap()

        let about = app.staticTexts["SAMPLE APP"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: about, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssert(about.exists)
    }
}
