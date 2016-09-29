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
        app.tables.cells.containing(.staticText, identifier:"プロトタイプ完成").buttons["WebView"].tap()

        let about = app.staticTexts["Sample App"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: about, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssert(about.exists)
        XCTAssert(app.staticTexts["Sign up now!"].exists)
    }
}
