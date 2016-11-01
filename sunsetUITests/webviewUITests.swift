import XCTest

class webviewUITests: XCTestCase {

    let formatter = DateFormatter()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments = [ "STUB_HTTP_ENDPOINTS" ]
        app.launch()
        
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
        super.tearDown()
    }

    func testMoveTweetPage() {
        let app = XCUIApplication()
        let loginUserName: String = "ビジ崎先輩格言bot"

        // テスト時、保存する前に画面を描写してくれないので、一度再描写させるために月を移動する
        app.buttons["←"].tap()
        app.buttons["→"].tap()
        app.tables.element(boundBy: 0).tap()
        
        let userNameLink = app.links[loginUserName]
        let userNameLinkExists = NSPredicate(format: "exists == 1")

        expectation(for: userNameLinkExists, evaluatedWith: userNameLink, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(userNameLink.exists)
    }
}
