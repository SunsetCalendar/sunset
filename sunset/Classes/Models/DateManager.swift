import UIKit

class DateManager: NSObject {
    var currentMonthOfDates: [Date] = [] //表記する月の配列
    var selectedDate: Date = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!

    // こちらで設定した初日から今日までいくつセルが必要か計算
    // -> 無限にスクロールさせることはできないので, 範囲を考える必要がある
    func countCellFromFirstDay(start: Date) -> Int {
        let startDate = Calendar.current.dateComponents([.year, .month], from: start)
        let currentDate = Calendar.current.dateComponents([.year, .month], from: self.selectedDate)

        // 何日離れているかの計算
        let numberOfDay = Calendar.current.dateComponents([.day], from: startDate, to: currentDate)
        return numberOfDay.day!
    }

    //月の初日を取得
    func firstDateOfMonth(date: Date) -> Date {
        var components: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)

        components.day = 1
        let firstDateMonth: Date = Calendar.current.date(from: components)!
        return firstDateMonth
    }

    // 各セルが何日なのかを, 設定した基準日を用いて計算
    func dateForCellAtIndexPath(row: Int, startDate: Date) -> Date {
        let ordinalityOfFirstDay: Int = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth(date: startDate))!
        var dateComponents: DateComponents = DateComponents()
        dateComponents.day = row - ordinalityOfFirstDay + 1
        
        let date = Calendar.current.date(byAdding: dateComponents, to: firstDateOfMonth(date: startDate))
        return date!
    }

    // 表記の変更
    func conversionDateFormat(row: Int, startDate: Date) -> String {
        let date = dateForCellAtIndexPath(row: row, startDate: startDate)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    func tagForCell(date: Date) -> Int {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "YYYYMM"
        return Int(formatter.string(from: date))!
    }
}
