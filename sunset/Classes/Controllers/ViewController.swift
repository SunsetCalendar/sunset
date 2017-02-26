import UIKit
import Gecco

@IBDesignable
class ViewController: UIViewController {

    @IBOutlet weak var headerPrevBtn: UIButton!
    @IBOutlet weak var headerNextBtn: UIButton!
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let formatter = DateFormatter()
    let TapPrevBtnNotification = Notification.Name("TapPrevBtn")
    let TapNextBtnNotification = Notification.Name("TapNextBtn")
    @IBInspectable var top: UIColor = UIColor.darkOrange()
    @IBInspectable var bottom: UIColor = UIColor.lightIndigo()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let formatter = DateFormatter()
        // 初期値 (今日の日付を元に、navigationBarのタイトルを決める)
        formatter.dateFormat = "MMM yyyy"
        self.title = formatter.string(from: Date())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let gradationView: GradationView = GradationView(topColor: top, bottomColor: bottom)
        gradationView.addGradation(view: self.view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 初回起動かのチェック
        let userDefaults = UserDefaults.standard
        if (userDefaults.bool(forKey: "firstLaunch")) {
            showWalkThrough()
            // 2回目以降は表示させないように
            userDefaults.set(false, forKey: "firstLaunch")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func generateTargetDate() -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        let thisDate = appDelegate.targetDate
        let year:String = (thisDate?.components(separatedBy: "-")[0])!
        let month:String = (thisDate?.components(separatedBy: "-")[1])!
        let day:String = (thisDate?.components(separatedBy: "-")[2])!
        
        let thisDateString = year + "-" + month + "-" + day
        return thisDateString
    }
    
    private func showWalkThrough() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WalkThrough") as! WalkThroughViewController
        viewController.alpha = 0.5
        present(viewController, animated: true, completion: nil)
    }
}

