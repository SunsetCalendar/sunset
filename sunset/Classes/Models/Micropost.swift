import Foundation
import SwiftyJSON

class Micropost {
    var content: String
    var created_at: String

    init(json: JSON) {
        self.content    = json["content"].stringValue
        self.created_at = json["created_at"].stringValue
    }

    static func fetchMicroposts(_ handler: @escaping ((Array<Micropost>) -> Void)) {
        APIClient.request(Endpoint.micropostIndex) { json in
            let microposts = json["feeds"].arrayValue.map { feeds in
                Micropost(json: feeds)
            }
            handler(microposts)
        }
    }
}
