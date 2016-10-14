import UIKit

extension Date {
    func monthAgoDate() -> Date {
        let addValue = -1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)!
    }
    
    func monthLaterDate() -> Date {
        let addValue: Int = 1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)!
    }
    
}

class DateManager: NSObject {
    var currentMonthOfDates = [Date]() //表記する月の配列
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    
    //月ごとのセルの数を返すメソッド
    func daysAcquisition() -> Int {
//        let rangeOfWeeks = Calendar.current.range(of: Calendar.Component.weekOfMonth, in: Calendar.Component.month, for: firstDateOfMonth())!

        //let numberOfWeeks = rangeOfWeeks.length //月が持つ週の数
//        let numberOfWeeks = rangeOfWeeks.count //月が持つ週の数
        let numberOfWeeks = 6

        numberOfItems = numberOfWeeks * daysPerWeek //週の数×列の数
        return numberOfItems
    }
    
    //月の初日を取得
    func firstDateOfMonth() -> Date {
        //var components = (Calendar.current as NSCalendar).components([.year, .month, .day], from: selectedDate)
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        
        
        components.day = 1
        let firstDateMonth = Calendar.current.date(from: components)!
        return firstDateMonth
    }
    
    func dateForCellAtIndexPath(_ numberOfItems: Int) {

        // 月の初日が週の何日目か を計算する
        let ordinalityOfFirstDay = Calendar.current.ordinality(of: Calendar.Component.day, in: Calendar.Component.weekOfMonth, for: firstDateOfMonth())!
        
        for i in 0...numberOfItems {
            // 月の初日 と indexPath.item番目のセルに表示する日 の差を計算する
            var dateComponents: DateComponents = DateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay - 1)
            //  表示する月の初日から②で計算した差を引いた日付を取得
            //let date = Calendar.current.date(byAdding: dateComponents, to: firstDateOfMonth(), wrappingComponents: true)!
            let date: Date = Calendar.current.date(byAdding: dateComponents, to: firstDateOfMonth())!
            
            // 配列に追加
            currentMonthOfDates.append(date)
        }
    }
    
    // 表記の変更
    func conversionDateFormat(_ indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row])
    }
    
    // 先月の表示
    func prevMonth(_ date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
    }
    
    // 次月の表示
    func nextMonth(_ date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
    }
    
    // その月にしかない日を返す
    func ShowDayIfInThisMonth(_ row: Int) -> String {
        dateForCellAtIndexPath(numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd"
        if row < 7 {
            if Int(formatter.string(from: currentMonthOfDates[row]))! > 7 {
                return ""
            }
        }
            
        else if row > 27 {
            if Int(formatter.string(from: currentMonthOfDates[row]))! <= 13 {
                return ""
            }
        }
        
        return formatter.string(from: currentMonthOfDates[row])
    }

}
