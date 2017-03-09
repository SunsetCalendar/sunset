import Foundation
import RealmSwift

class TweetManager {

    let realm: Realm = try! Realm()
    
    // NOTE: 雑に全部消してる
    func deleteAll() {
        do {
            try self.realm.write() {
                self.realm.deleteAll()
            }
        } catch {
            let error: NSError = error as NSError
            print("error: \(error), \(error.userInfo)")
        }

    }
    
    func filter(date: String) -> [Tweet] {
        let fetchData: [Tweet] = self.realm.objects(Tweet.self).filter("created_at BEGINSWITH %@", date).map{$0}
        return fetchData
    }
}
