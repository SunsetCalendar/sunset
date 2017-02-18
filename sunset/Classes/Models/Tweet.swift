import Foundation
import RealmSwift

class Tweet: Object {

    dynamic var tweet_id: String = ""
    dynamic var user_id: String = ""
    dynamic var content: String = ""
    dynamic var created_at: String = ""
    
    override static func primaryKey() -> String? {
        return "tweet_id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["created_at"]
    }

    func deleteAll() {
        do {
            try realm?.write() {
                realm?.deleteAll()
            }
        } catch {
            let error = error as NSError
            print("error: \(error), \(error.userInfo)")
        }
    }
}
