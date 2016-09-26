import Foundation

class Micropost {
    var content: String

    init(content: String) {
        self.content = content
    }

    static func fetchMicroposts(_ handler: @escaping ((Array<Micropost>) -> Void)) {
        APIClient.request(Endpoint.micropostIndex) { json in
            let microposts = json["feeds"].arrayValue.map {
                Micropost(content: $0["content"].stringValue)
            }
            handler(microposts)
        }
    }
}
