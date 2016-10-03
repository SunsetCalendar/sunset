import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    let baseUrl: String = "https://asuforce.xyz/users/"
    var id: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.delegate = self

        let initUrl = URL(string: baseUrl + id!)

        let request = URLRequest(url: initUrl!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
