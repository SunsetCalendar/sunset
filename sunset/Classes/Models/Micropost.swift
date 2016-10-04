import Foundation
import SwiftyJSON

class Micropost {
    var id: Int32
    var content: String
    var created_at: String

    init(json: JSON) {
        self.id         = json["id"].int32Value
        self.content    = json["content"].stringValue
        self.created_at = json["created_at"].stringValue
    }

    static func fetchMicroposts(_ handler: @escaping ((Array<Micropost>) -> Void)) {
        APIClient.request(Endpoint.micropostIndex) { json in
            let microposts = json["feeds"].arrayValue.map { feed in
                Micropost(json: feed)
            }
            handler(microposts)
        }
    }
}
