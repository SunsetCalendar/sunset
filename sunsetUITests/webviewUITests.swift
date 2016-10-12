import XCTest

class webviewUITests: XCTestCase {

    let formatter = DateFormatter()

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

        formatter.dateFormat = "MMM yyyy"
        let nowDate: String = formatter.string(from: Date())

        // テスト時、保存する前に画面を描写してくれないので、一度再描写させるために月を移動する
        app.navigationBars[nowDate].buttons["←"].tap()
        app.tables.staticTexts["Apple"].tap()

        let about = app.staticTexts["ORPHEUS"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: about, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssert(about.exists)
    }
}
