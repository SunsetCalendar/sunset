import UIKit

class MicropostViewController: UITableViewController {

    var microposts = [Micropost]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Micropost.fetchMicroposts { microposts in
            self.microposts = microposts
            self.tableView.reloadData()
        }
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

    private func updateCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        cell.textLabel?.text = self.microposts[indexPath.row].content
    }
}
