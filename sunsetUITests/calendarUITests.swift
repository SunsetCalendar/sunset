//
//  sunsetUITests.swift
//  sunsetUITests
//
//  Created by usr0600429 on 2016/09/08.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class sunsetUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // 年の切り替わりによる月の変更 (12から1月、またその逆の対策)
    func calcDate(year: Int, month: Int, check: String) -> String {
        if check == "+" {
            if month == 12 {
                return String(year + 1) + "/1"
            }
            else {
                return String(year) + "/" + String(month + 1)
            }
        }
        
        else {
            if month == 1 {
                return String(year - 1) + "/12"
            }
            else {
                return String(year) + "/" + String(month - 1)
            }
        }
    }
    
    func testMoveMonthButton() {
        let app = XCUIApplication()
        
        // Main.storyboardに集約する際には必要ない
        let toCalendarButton = app.buttons["カレンダー"]
        toCalendarButton.tap()
        
        let agoButton = app.buttons["←"]
        let laterButton = app.buttons["→"]
        let dateLabel = app.staticTexts["dateLabel"]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M"
        
        let date = Date()
        let this_year = Int(formatter.string(from: date).components(separatedBy: "/")[0])!
        let this_month = Int(formatter.string(from: date).components(separatedBy: "/")[1])!
        var expectedLabel = ""
        
        XCTAssertEqual(String(this_year) + "/" + String(this_month), dateLabel.label)
        
        // 1ヶ月戻る
        agoButton.tap()
        
        expectedLabel = calcDate(year: this_year, month: this_month, check: "-")
        XCTAssertEqual(expectedLabel, dateLabel.label)
        
        // スタート時に戻る
        laterButton.tap()
        
        // 1ヶ月進む
        laterButton.tap()
        
        expectedLabel = calcDate(year: this_year, month: this_month, check: "+")
        XCTAssertEqual(expectedLabel, dateLabel.label)
        
    }

}
