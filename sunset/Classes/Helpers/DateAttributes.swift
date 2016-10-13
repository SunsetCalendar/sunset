import UIKit
import CoreData
import RealmSwift

class DateAttributes {

    let realm: Realm = try! Realm()
    
    // その日に投稿があったか
    func existPosts(dayLabel: String) -> Bool {
        var day: String = dayLabel
        // 1桁の場合、接頭辞として'0'を付与
        if dayLabel.characters.count == 1 {
            day = "0" + dayLabel
        }
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()

        let year: String = (appDelegate.targetDate?.components(separatedBy: "-")[0])!
        let month: String = (appDelegate.targetDate?.components(separatedBy: "-")[1])!
        let date: String = year + "-" + month + "-" + day
//        let predicate: NSPredicate = NSPredicate(format: "created_at BEGINSWITH %@", date)
//        fetchRequest.predicate = predicate
        let fetchData: [Post] = realm.objects(Post.self).filter("created_at BEGINSWITH %@", date).map{$0}
//        let fetchData = try! managedObjectContext.fetch(fetchRequest)
        if fetchData.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    // 表示されている日がその月のものかどうかを返す
    func isThisMonth(day: String, row: Int) -> Bool {
        if (row < 7) {
            if (Int(day)! > 7) {
                return false
            } else if (row > 28) {
                if (Int(day)! < 7) {
                    return false
                }
            }
        }
        return true
    }
}
