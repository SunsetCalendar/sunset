import XCTest

class micropostUITests: XCTestCase {
    
    let formatter: DateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app: XCUIApplication = XCUIApplication()
        app.launchArguments = [ "STUB_HTTP_ENDPOINTS" ]
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShowSettingsWhenSwipeFromLeft() {
        let app: XCUIApplication = XCUIApplication()
        let accountLabel: XCUIElement = app.staticTexts["アカウント"]
        let twitterCell: XCUIElement = app.tables.cells.staticTexts["Twitter"]
        
        app.swipeLeft()
        XCTAssertTrue(accountLabel.exists)
        XCTAssertTrue(twitterCell.exists)
    }
}
