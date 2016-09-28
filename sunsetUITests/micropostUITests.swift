import XCTest

class micropostUITests: XCTestCase {

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
        app.buttons["Micropost"].tap()

        XCTAssertTrue(app.tables.staticTexts["hoge"].exists)
        //XCTAssertTrue(app.tables.staticTexts["わくわく"].exists)
    }

}
