import XCTest
import Foundation

@testable import sunset

class DateManagerTests: XCTestCase {
    
    let formatter = DateFormatter()
    let currentDate: Date = Date()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMonthAgoDate() {
        var components: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
        components.month = 01
        formatter.dateFormat = "YYYYMM"
        let date: Date = Calendar.current.date(from: components)!
        let lastMonthDate = formatter.string(from: date.monthAgoDate())
        XCTAssertEqual(lastMonthDate, "\(components.year! - 1)12")
    }

    func testMonthLaterDate() {
        var components: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
        components.month = 12
        formatter.dateFormat = "YYYYMM"
        let date: Date = Calendar.current.date(from: components)!
        let lastMonthDate = formatter.string(from: date.monthLaterDate())
        XCTAssertEqual(lastMonthDate, "\(components.year! + 1)01")
    }
}
