import XCTest

class webviewUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments = [ "STUB_HTTP_ENDPOINTS" ]
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShowMicroposts() {
        let app = XCUIApplication()
        
        // 保存する前に画面を描写するので、一度再描写させるために月を移動する
        let agoButton = app.buttons["←"]
        agoButton.tap()
        app.tables.cells.containing(.staticText, identifier:"Apple").buttons["WebView"].tap()

        let about = app.staticTexts["Sample App"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: about, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssert(about.exists)
        XCTAssert(app.staticTexts["Sign up now!"].exists)
    }
}
