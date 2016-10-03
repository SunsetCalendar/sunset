import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post");
    }

    @NSManaged public var content: String?
    @NSManaged public var created_at: String?
    @NSManaged public var user_id: Int16

}
