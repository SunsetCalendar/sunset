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

}
