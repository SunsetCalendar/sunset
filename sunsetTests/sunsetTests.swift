//
//  sunsetTests.swift
//  sunsetTests
//
//  Created by usr0600429 on 2016/09/08.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest
@testable import sunset

class sunsetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoveMonth() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        // 現在の日時を取得
        let date = Date()
        
        // 1ヶ月前、後の日時を取得
        let ago_date = date.monthAgoDate()
        let later_date = date.monthLaterDate()
        
        // dateから月だけ抽出するようにする (1, 2など)
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        
        let this_month = Int(formatter.string(from: date))!
        let ago_month = Int(formatter.string(from: ago_date))!
        let later_month = Int(formatter.string(from: later_date))!
        
        
        let ago_diff_check = abs(this_month - ago_month % 12)
        let later_diff_check = abs(later_month - this_month % 12)
        
        
        XCTAssertEqual(ago_diff_check, 1)
        XCTAssertEqual(later_diff_check, 1)
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
