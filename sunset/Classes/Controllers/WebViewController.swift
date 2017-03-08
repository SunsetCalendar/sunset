import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tweetId: String? = appDelegate.tweetID
        let userId: String? = appDelegate.userID
        
        let baseUrl: String = "https://twitter.com/"
        
        let initUrl: URL? = URL(string: baseUrl + userId! + "/status/" + tweetId!)
        
        let request: URLRequest = URLRequest(url: initUrl!)
        self.webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
