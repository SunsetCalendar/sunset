import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    let initUrl = URL(string: "http://google.com/")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.delegate = self

        let request = URLRequest(url: initUrl!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
