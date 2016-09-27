//
//  sunsetTests.swift
//  sunsetTests
//
//  Created by usr0600429 on 2016/09/08.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest
import Foundation

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
        
        
        // 現在の年月日を取得
        let date = Date()
        
        // 1ヶ月前、後の年月日を取得
        let ago_date = date.monthAgoDate(), later_date = date.monthLaterDate()
        
        // 取得した年月日からから月だけ抽出するように (1, 2など)
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        
        let this_month = Int(formatter.string(from: date))!
        let ago_month = Int(formatter.string(from: ago_date))!
        let later_month = Int(formatter.string(from: later_date))!
        
        // 今の月との差異
        let ago_diff_check = abs(this_month - ago_month % 12)
        let later_diff_check = abs(later_month - this_month % 12)
        
        XCTAssertEqual(ago_diff_check, 1)
        XCTAssertEqual(later_diff_check, 1)
    }
    
    func testChangesYear() {
        var date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M"
        
        let this_year = Int(formatter.string(from: date).components(separatedBy: "-")[0])!
        let this_month = Int(formatter.string(from: date).components(separatedBy: "-")[1])!
        
        // 年が変わるまで進める
        for _ in 1...(13 - this_month) {
          date = date.monthLaterDate()
        }
        
        let laterDate = Int(formatter.string(from: date).components(separatedBy: "-")[0])!
        XCTAssertEqual(laterDate, this_year + 1)
        
        // 年が変わるまで戻る
        for _ in 1...13 {
            date = date.monthAgoDate()
        }
        
        let agoDate = Int(formatter.string(from: date).components(separatedBy: "-")[0])!
        XCTAssertEqual(agoDate, this_year - 1)
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
