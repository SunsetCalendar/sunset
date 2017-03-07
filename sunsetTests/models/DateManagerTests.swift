import XCTest
import Foundation

@testable import sunset

class DateManagerTests: XCTestCase {
    
    let formatter: DateFormatter = DateFormatter()
    let currentDate: Date = Date()
    let dateManager: DateManager = DateManager()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 境界部分のテスト
    func testMonthAgoDate() {
        var components: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
        components.month = 01
        formatter.dateFormat = "YYYYMM"
        let date: Date = Calendar.current.date(from: components)!
        let lastMonthDate: String = formatter.string(from: date.monthAgoDate())
        let expectedDate: String = String(components.year! - 1) + "12"
        XCTAssertEqual(lastMonthDate, expectedDate, "Expect \(lastMonthDate) to equal \(expectedDate)")
    }

    // 境界部分のテスト
    func testMonthLaterDate() {
        var components: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
        components.month = 12
        formatter.dateFormat = "YYYYMM"
        let date: Date = Calendar.current.date(from: components)!
        let laterMonthDate: String = formatter.string(from: date.monthLaterDate())
        let expectedDate: String = String(components.year! + 1) + "01"
        XCTAssertEqual(laterMonthDate, "\(expectedDate)", "Expect \(laterMonthDate) to equal \(expectedDate)")
    }
    
    func testFirstDateOfMonth() {
        formatter.dateFormat = "dd"
        let firstDate: String = formatter.string(from: self.dateManager.firstDateOfMonth())
        XCTAssertEqual(firstDate, "01")
    }
}
