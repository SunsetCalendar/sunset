import UIKit
import CoreData

class MicropostViewController: UITableViewController {

    var microposts = [Micropost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        savePosts()
        
        // targetDateの初期値 (今日の日付) をセット
        if appDelegate.targetDate == nil {
            print("Initialize!")
            appDelegate.targetDate = initialDate()
        }


        let MyNotification = Notification.Name("Mynotification")
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView(_:)), name: MyNotification, object: nil)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return filterPosts(date: appDelegate.targetDate!).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "micropostCell", for: indexPath)

        updateCell(cell, indexPath: indexPath)

        return cell
    }

    private func updateCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //var posts = filterPosts(date: appDelegate.targetDate!)
        var posts = filterPosts(date: appDelegate.targetDate!)
        cell.textLabel?.text = posts[indexPath.row].content
    }

    @objc func updateView(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    func savePosts() {
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        let managedObjectContext = container.viewContext
        managedObjectContext.mergePolicy = NSRollbackMergePolicy
        
        Micropost.fetchMicroposts { microposts in
            //self.microposts = microposts
            
            for micropost in microposts {
                
                let post = NSEntityDescription.insertNewObject(forEntityName: "Post", into: managedObjectContext) as! Post
                post.content = micropost.content
                post.created_at = micropost.created_at
                print(post.content, post.created_at)
                
                do {
                    try managedObjectContext.save()
                    print("Saved！！！！！")
                } catch {
                    let error = error as NSError
                    print("\(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func filterPosts(date: String) -> [Post] {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        let managedObjectContext = container.viewContext
        
        
        let fetchRequest:NSFetchRequest<Post> = Post.fetchRequest()
        //let predicate = NSPredicate(format: "created_at = %@", appDelegate.targetDate) <- こうなる予定
        let predicate = NSPredicate(format: "created_at BEGINSWITH %@", date)
        fetchRequest.predicate = predicate
        let fetchData = try! managedObjectContext.fetch(fetchRequest)
        return fetchData
    }
    
    func initialDate() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        return today
        //return "2016-09-27"
    }

}
