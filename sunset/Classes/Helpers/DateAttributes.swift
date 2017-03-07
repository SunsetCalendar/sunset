import UIKit
import RealmSwift

class DateAttributes {

    let realm: Realm = try! Realm()
    
    // その日に投稿があったか
    func existPosts(dayLabel: String) -> Bool {
        var day: String = dayLabel
        // 1桁の場合、接頭辞として'0'を付与
        if (dayLabel.characters.count == 1) {
            day = "0" + dayLabel
        }
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

        let year: String = (appDelegate.targetDate?.components(separatedBy: "-")[0])!
        let month: String = (appDelegate.targetDate?.components(separatedBy: "-")[1])!
        let date: String = year + "-" + month + "-" + day
        let fetchData: [Tweet] = realm.objects(Tweet.self).filter("created_at BEGINSWITH %@", date).map{$0}

        if (fetchData.count == 0) {
            return false
        }
        return true
    }

    // 曜日の色の振り分け
    func choiceDaysColor(row: Int) -> UIColor {
        switch (row % 7) {
        case 0:
            return UIColor.red
        case 6:
            return UIColor.blue
        default:
            return UIColor.white
        }
    }
}
