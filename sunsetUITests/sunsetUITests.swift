import XCTest

class sunsetUITests: XCTestCase {
    
    let formatter = DateFormatter()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments = [ "STUB_HTTP_ENDPOINTS" ]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func changeDate(date: String, check: String) -> String {
        let month: String = date.components(separatedBy: " ")[0]
        let year = Int(date.components(separatedBy: " ")[1])!
        
        var calendarShortened = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        if check == "+" {
            if month == "Dec" {
                return "Jan " + String(year + 1)
            }
            else {
                return calendarShortened[calendarShortened.index(of: month)! + 1] + " " + String(year)
            }
        }

        else {
            if month == "Jan" {
                return "Dec " + String(year - 1)
            }
            else {
                return calendarShortened[calendarShortened.index(of: month)! - 1] + " " + String(year)
            }
        }

    }
    
    // ボタン移動
    func testMoveCalendarByTappingBtn() {
        let app = XCUIApplication()
        formatter.dateFormat = "MMM yyyy"
        let nowDate: String = formatter.string(from: Date())
        let prevDate: String = changeDate(date: nowDate, check: "-")
        let nowDateLabel = app.staticTexts[nowDate]
        let prevDateLabel = app.staticTexts[prevDate]
        XCTAssertTrue(nowDateLabel.exists)
        app.navigationBars[nowDate].buttons["←"].tap()
        XCTAssertTrue(prevDateLabel.exists)
        app.navigationBars[prevDate].buttons["→"].tap()
        XCTAssertTrue(nowDateLabel.exists)
    }
}
