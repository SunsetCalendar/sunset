import UIKit

class MicropostViewController: UITableViewController {

    var microposts = [Micropost]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Micropost.fetchMicroposts { microposts in
            self.microposts = microposts
            self.tableView.reloadData()
        }

        let MyNotification = Notification.Name("Mynotification")
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView(_:)), name: MyNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.microposts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "micropostCell", for: indexPath)

        updateCell(cell, indexPath: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.micropost_id = "5"
        performSegue(withIdentifier: "showWebView",sender: nil)
    }

    private func updateCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        cell.textLabel?.text = self.microposts[indexPath.row].content
    }

    @objc func updateView(_ notification: Notification) {
        self.tableView.reloadData()
    }
}
