import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.delegate = self

        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

        let id = appDelegate.micropostId
        let baseUrl: String = "https://asuforce.xyz/microposts/"

        let initUrl = URL(string: baseUrl + id!)

        let request = URLRequest(url: initUrl!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
