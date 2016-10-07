import UIKit
import CoreData

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
}

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let dateManager: DateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 1.0 //2.0
    var selectedDate: Date = Date()
    var today: Date!
    let weekArray: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let TapCalendarCellNotification = Notification.Name("TapCelandarCell")
    
    @IBOutlet var swipeLeftGesture: UISwipeGestureRecognizer!
    @IBOutlet var swipeRightGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!

    // [左へスワイプ] 1ヶ月進む
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        selectedDate = dateManager.nextMonth(selectedDate)
        calendarCollectionView.reloadData()
        // 月が変更する際にnavigationBarのタイトルも更新
        // navigationBarは親であるViewControllerが所持しているので、親の要素を書き換える
        self.parent?.title = changeHeaderTitle(selectedDate)
    }
    
    // [右へスワイプ] 1ヶ月戻る
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        selectedDate = dateManager.prevMonth(selectedDate)
        calendarCollectionView.reloadData()
        // 月が変更する際にnavigationBarのタイトルも更新
        // navigationBarは親であるViewControllerが所持しているので、親の要素を書き換える
        self.parent?.title = changeHeaderTitle(selectedDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.backgroundColor = UIColor.white
        
        let TapPrevBtnNotification = Notification.Name("TapPrevBtn")
        let TapNextBtnNotification = Notification.Name("TapNextBtn")
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatePrevView(_:)), name: TapPrevBtnNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateNextView(_:)), name: TapNextBtnNotification, object: nil)

        self.calendarCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
        if (section == 0) {
            return 7
        } else {
            return dateManager.daysAcquisition() //ここは月によって異なる
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        //テキストカラー
        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.textLabel.textColor = UIColor.lightBlue()
        } else {
            cell.textLabel.textColor = UIColor.gray
        }
        
        //テキスト配置
        if (indexPath.section == 0) {
            cell.textLabel.text = weekArray[indexPath.row]
        } else {
            cell.textLabel.text = dateManager.conversionDateFormat(indexPath)
        }
        return cell
    }
    
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let numberOfMargin: CGFloat = 8.0  //8.0
        let width: CGFloat = (collectionView.frame.size.width) / CGFloat(daysPerWeek + 1)
        
        let height: CGFloat = width// 正方形にしなくても良さそう
        return CGSize(width: width, height: height)
    }
    
    //セルの垂直方向のマージンを設定
    //func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //    return cellMargin
    //}

    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    // cellをtapした直後のアクション
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section != 0) {
            let cell : CalendarCell = collectionView.cellForItem(at: indexPath)! as! CalendarCell
            cell.hexImageView.image = UIImage(named: "hexagon")
        }

        let day = dateManager.ShowDayIfInThisMonth(indexPath.row)
        if (day != "") {
            let year: String = (self.appDelegate.targetDate?.components(separatedBy: "-")[0])!
            let month: String = (self.appDelegate.targetDate?.components(separatedBy: "-")[1])!
            self.appDelegate.targetDate = year + "-" + month + "-" + day
        }

        NotificationCenter.default.post(name: TapCalendarCellNotification, object: nil)
    }

    // タップしたcellの前のcellに対するアクション
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell : CalendarCell = collectionView.cellForItem(at: indexPath)! as! CalendarCell
        cell.hexImageView.image = nil
    }

    //headerの月を変更
    func changeHeaderTitle(_ date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let selectMonth = formatter.string(from: date)
        formatter.dateFormat = "yyyy-MM"
        let Month4Calc = formatter.string(from: date)
        updateTargetDate(date: Month4Calc)
        return selectMonth
    }
    
    // 月が変更する際に、appDelegate側の変数も更新する
    func updateTargetDate(date: String) {
        let day: String = (self.appDelegate.targetDate?.components(separatedBy: "-")[2])!
        appDelegate.targetDate = date + "-" + day
        NotificationCenter.default.post(name: TapCalendarCellNotification, object: nil)
    }
    
    @objc func updatePrevView(_ notification: Notification) {
        selectedDate = dateManager.prevMonth(selectedDate)
        self.parent?.title = changeHeaderTitle(selectedDate)
        calendarCollectionView.reloadData()
    }
    
    @objc func updateNextView(_ notification: Notification) {
        selectedDate = dateManager.nextMonth(selectedDate)
        self.parent?.title = changeHeaderTitle(selectedDate)
        calendarCollectionView.reloadData()
    }
}
