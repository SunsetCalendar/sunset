import Foundation
import RealmSwift

class Post: Object {
    dynamic var micropost_id: Int32 = 0
    dynamic var content: String = ""
    dynamic var created_at: String = ""

    override static func primaryKey() -> String? {
        return "micropost_id"
    }

    override static func indexedProperties() -> [String] {
        return ["created_at"]
    }
}
