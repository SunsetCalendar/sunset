import UIKit
import RealmSwift
import TwitterKit

class MicropostViewController: UITableViewController {

    var tweets: [Tweet] = []
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let realm: Realm = try! Realm()
    let sessionStore = Twitter.sharedInstance().sessionStore

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

        let TapCalendarCellNotification = Notification.Name("TapCelandarCell")
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView(_:)), name: TapCalendarCellNotification, object: nil)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPosts(date: self.appDelegate.targetDate!).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "micropostCell", for: indexPath)
        if (self.sessionStore.session()?.userID != nil) {
            updateCell(cell, indexPath: indexPath)
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let tweets: [Tweet] = filterPosts(date: self.appDelegate.targetDate!)
        appDelegate.tweetID = tweets[indexPath.row].tweet_id
        appDelegate.userID = tweets[indexPath.row].user_id
    }

    private func updateCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        let tweets: [Tweet] = filterPosts(date: self.appDelegate.targetDate!)
        cell.textLabel?.text = tweets[indexPath.row].content
    }

    @objc func updateView(_ notification: Notification) {
        self.tableView.reloadData()
    }

    private func filterPosts(date: String) -> [Tweet] {
        let fetchData: [Tweet] = realm.objects(Tweet.self).filter("created_at BEGINSWITH %@", date).map{$0}
        return fetchData
    }
    
    private func initialDate() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today: String = formatter.string(from: Date())
        return today
    }
}
