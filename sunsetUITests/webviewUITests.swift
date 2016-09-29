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

        XCTAssertTrue(app.staticTexts["WebViewだよ"].exists)
    }
}
