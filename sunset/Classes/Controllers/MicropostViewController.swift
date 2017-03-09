import UIKit
import TwitterKit

class MicropostViewController: UITableViewController {

    var tweets: [Tweet] = []
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let sessionStore: TWTRSessionStore = Twitter.sharedInstance().sessionStore
    let tweetManager: TweetManager = TweetManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.sessionStore.session()?.userID != nil) {
            let twitterAPIClient: TwitterAPIClient = TwitterAPIClient()
            twitterAPIClient.savePosts()
        }
        self.view.backgroundColor = UIColor.clear

        // targetDateの初期値 (今日の日付) をセット
        if self.appDelegate.targetDate == nil {
            appDelegate.targetDate = initialDate()
        }

        let TapCalendarCellNotification: Notification.Name = Notification.Name("TapCelandarCell")
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView(_:)), name: TapCalendarCellNotification, object: nil)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetManager.filter(date: self.appDelegate.targetDate!).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "micropostCell", for: indexPath)
        if (self.sessionStore.session()?.userID != nil) {
            updateCell(cell, indexPath: indexPath)
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let tweets: [Tweet] = self.tweetManager.filter(date: self.appDelegate.targetDate!)
        appDelegate.tweetID = tweets[indexPath.row].tweet_id
        appDelegate.userID = tweets[indexPath.row].user_id
    }

    private func updateCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        let tweets: [Tweet] = self.tweetManager.filter(date: self.appDelegate.targetDate!)
        cell.textLabel?.text = tweets[indexPath.row].content
    }

    @objc func updateView(_ notification: Notification) {
        self.tableView.reloadData()
    }

    private func initialDate() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today: String = formatter.string(from: Date())
        return today
    }
}
