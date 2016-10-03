import XCTest
import Foundation

@testable import sunset

class sunsetTests: XCTestCase {
    
    let calendarShortened = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoveMonth() {
        // 現在の年月日を取得
        let date = Date()
        
        // 1ヶ月前、後の年月日を取得
        let lastMonthDate = date.monthAgoDate(), nextMonthdate = date.monthLaterDate()
        
        // 取得した年月日からから月だけ抽出するように (1, 2など)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        
        let thisMonth = formatter.string(from: date)
        let lastMonth = formatter.string(from: lastMonthDate)
        let laterMonth = formatter.string(from: nextMonthdate)
        
        // 今の月との差異
        let agoDiffCheck = abs(calendarShortened.index(of: thisMonth)! - calendarShortened.index(of: lastMonth)! % 12)
        let laterDiffCheck = abs(calendarShortened.index(of: laterMonth)! - calendarShortened.index(of: thisMonth)! % 12)
        
        XCTAssertEqual(agoDiffCheck, 1)
        XCTAssertEqual(laterDiffCheck, 1)
    }
    
    func testChangesYear() {
        var date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        
        let thisYear = Int(formatter.string(from: date).components(separatedBy: " ")[1])!
        let thisMonth = formatter.string(from: date).components(separatedBy: " ")[0]
        
        // 年が変わるまで進める
        for _ in 1...(12 - calendarShortened.index(of: thisMonth)!) {
          date = date.monthLaterDate()
        }
        
        let nextYear = Int(formatter.string(from: date).components(separatedBy: " ")[1])!
        XCTAssertEqual(nextYear, thisYear + 1)
        
        // 年が変わるまで戻る
        for _ in 1...13 {
            date = date.monthAgoDate()
        }
        
        let lastYear = Int(formatter.string(from: date).components(separatedBy: " ")[1])!
        XCTAssertEqual(lastYear, thisYear - 1)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
