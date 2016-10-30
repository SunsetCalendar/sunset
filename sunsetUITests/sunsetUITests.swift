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
        
        // Twitterのログイン処理を事前に済ませる
        let element = app.otherElements["main"].children(matching: .other).element(boundBy: 2)
        let textField = element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        textField.tap()
        
        textField.typeText("busizaki")
        let secureTextField = element.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("wass3359")
        app.buttons["Sign In"].tap()
        sleep(5)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func changeDate(date: String, check: String) -> String {
        let month: String = date.components(separatedBy: " ")[0]
        let year = Int(date.components(separatedBy: " ")[1])!
        
        var calendarShortened = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        if (check == "+") {
            if (month == "Dec") {
                return "Jan " + String(year + 1)
            } else {
                return calendarShortened[calendarShortened.index(of: month)! + 1] + " " + String(year)
            }
        } else {
            if (month == "Jan") {
                return "Dec " + String(year - 1)
            }
            else {
                return calendarShortened[calendarShortened.index(of: month)! - 1] + " " + String(year)
            }
        }

    }

    // ログインしたらカレンダーが見えるか
    func testShowCalendarAfterLogin() {
        let app = XCUIApplication()
        formatter.dateFormat = "MMM yyyy"
        let nowDate: String = formatter.string(from: Date())
        let nowDateLabel = app.staticTexts[nowDate]
        let prevDate: String = changeDate(date: nowDate, check: "-")
        let prevDateLabel = app.staticTexts[prevDate]
        let dateFirstLabel = app.staticTexts["1"]
        
        XCTAssertTrue(nowDateLabel.exists)
        XCTAssertTrue(dateFirstLabel.exists)
        
        app.buttons["←"].tap()
        XCTAssertTrue(prevDateLabel.exists)
        app.buttons["→"].tap()
        XCTAssertTrue(nowDateLabel.exists)
        
    }
    
    // ボタン移動で月が切り替わるか
//    func testMoveCalendarByTappingBtn() {
//        let app = XCUIApplication()
//        formatter.dateFormat = "MMM yyyy"
//        let nowDate: String = formatter.string(from: Date())
//        let prevDate: String = changeDate(date: nowDate, check: "-")
//        let nowDateLabel = app.staticTexts[nowDate]
//        let prevDateLabel = app.staticTexts[prevDate]
//        
//        app.buttons["←"].tap()
//        XCTAssertTrue(prevDateLabel.exists)
//        app.buttons["→"].tap()
//        XCTAssertTrue(nowDateLabel.exists)
//    }
    
    // ツイートが表示されているか
//    func testShowPosts() {
//        let app = XCUIApplication()
//        let labelPredicate = NSPredicate(format: "label MATCHES '.+'")
//        formatter.dateFormat = "MMM yyyy"
//        let nowDate: String = formatter.string(from: Date())
//        let prevDate: String = changeDate(date: nowDate, check: "-")
//
//        app.navigationBars[nowDate].buttons["←"].tap()
//        let textLabel = app.tables.staticTexts.element(matching: labelPredicate)
//        app.navigationBars[prevDate].buttons["→"].tap()
//        XCTAssert(textLabel.exists)
//    }
}
