import UIKit
import CoreData

class MicropostViewController: UITableViewController {

    var microposts = [Micropost]()
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        savePosts()
        
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
        updateCell(cell, indexPath: indexPath)
        return cell
    }

    private func updateCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        var posts = filterPosts(date: self.appDelegate.targetDate!)
        cell.textLabel?.text = posts[indexPath.row].content
    }

    @objc func updateView(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    private func savePosts() {
        let container = self.appDelegate.persistentContainer
        let managedObjectContext = container.viewContext
        managedObjectContext.mergePolicy = NSRollbackMergePolicy
        
        Micropost.fetchMicroposts { microposts in
            
            for micropost in microposts {
                
                let post = NSEntityDescription.insertNewObject(forEntityName: "Post", into: managedObjectContext) as! Post
                post.content = micropost.content
                post.created_at = micropost.created_at
                print(post.content, post.created_at)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    let error = error as NSError
                    print("\(error), \(error.userInfo)")
                }
            }
        }
    }
    
    private func filterPosts(date: String) -> [Post] {
        let container = self.appDelegate.persistentContainer
        let managedObjectContext = container.viewContext
        let fetchRequest:NSFetchRequest<Post> = Post.fetchRequest()
        // 日付で前方一致をかけて検索 (保存されている日付の形式が "2016-01-01T12:00:00" のため)
        let predicate = NSPredicate(format: "created_at BEGINSWITH %@", date)
        fetchRequest.predicate = predicate
        let fetchData = try! managedObjectContext.fetch(fetchRequest)
        return fetchData
    }
    
    private func initialDate() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        return today
    }
}
