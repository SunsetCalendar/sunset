import Foundation
import Alamofire

class APIClient {
//    static fileprivate let baseUrl = "https://asuforce.xyz"
//
//    static func request(_ endpoint: Endpoint, handler: @escaping (_ json: JSON) -> Void) {
//        let method = endpoint.method()
//        let url = fullURL(endpoint)
//
//        Alamofire.request(url, method: method).validate(statusCode: 200...299).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                handler(JSON(value))
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//    static fileprivate func fullURL(_ endpoint: Endpoint) -> String {
//        return baseUrl + endpoint.path()
//    }
//}
//
//enum Endpoint {
//    case micropostIndex
//
//    func method() -> Alamofire.HTTPMethod {
//        return .get
//    }
//
//    func path() -> String {
//        switch self {
//            case .micropostIndex:
//                return "/api/users/5" // とりあえずuser決め打ち
//        }
//    }
}
