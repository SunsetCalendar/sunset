import UIKit

class MicropostViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Micropost.fetchMicroposts { microposts in
            print(microposts)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

