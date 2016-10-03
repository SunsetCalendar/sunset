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
        let calendarShortened = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        // 現在の年月日を取得
        let date = Date()
        
        // 1ヶ月前、後の年月日を取得
        let ago_date = date.monthAgoDate(), later_date = date.monthLaterDate()
        
        // 取得した年月日からから月だけ抽出するように (1, 2など)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        
        let this_month = formatter.string(from: date)
        let ago_month = formatter.string(from: ago_date)
        let later_month = formatter.string(from: later_date)
        
        // 今の月との差異
        let ago_diff_check = abs(calendarShortened.index(of: this_month)! - calendarShortened.index(of: ago_month)! % 12)
        let later_diff_check = abs(calendarShortened.index(of: later_month)! - calendarShortened.index(of: this_month)! % 12)
        
        XCTAssertEqual(ago_diff_check, 1)
        XCTAssertEqual(later_diff_check, 1)
    }
    
    func testChangesYear() {
        let calendarShortened = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

        var date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        
        let this_year = Int(formatter.string(from: date).components(separatedBy: " ")[1])!
        let this_month = formatter.string(from: date).components(separatedBy: " ")[0]
        
        // 年が変わるまで進める
        for _ in 1...(12 - calendarShortened.index(of: this_month)!) {
          date = date.monthLaterDate()
        }
        
        let laterYear = Int(formatter.string(from: date).components(separatedBy: " ")[1])!
        XCTAssertEqual(laterYear, this_year + 1)
        
        // 年が変わるまで戻る
        for _ in 1...13 {
            date = date.monthAgoDate()
        }
        
        let agoYear = Int(formatter.string(from: date).components(separatedBy: " ")[1])!
        XCTAssertEqual(agoYear, this_year - 1)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
