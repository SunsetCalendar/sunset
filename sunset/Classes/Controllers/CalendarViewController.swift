import UIKit
import RealmSwift

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let dateAttributes: DateAttributes = DateAttributes()
    let dateManager: DateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate: Date = Date()
    var prevDay: String!
    var prevIndexPath: IndexPath?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let TapCalendarCellNotification = Notification.Name("TapCelandarCell")
    let realm: Realm = try! Realm()
    var notificationToken: NotificationToken? = nil
    let startDate: Date = Calendar.current.date(from: DateComponents(year: 2016, month: 01, day: 01))!

    @IBOutlet weak var calendarCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tweetModel = self.realm.objects(Tweet.self)

        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.clear

        // Realm の Tweet object の変化を監視し, 変化があったら中で定義したメソッドを実行
        // ref. https://realm.io/jp/docs/swift/latest/#section-39
        self.notificationToken = tweetModel.addNotificationBlock { notification in
            self.calendarCollectionView.reloadData()
        }
        calendarCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateManager.countCellFromFirstDay(start: self.startDate)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let date: Date = dateManager.dateForCellAtIndexPath(row: indexPath.row, startDate: self.startDate)
        let cell: CalendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell

        cell.textLabel.textColor = dateAttributes.choiceDaysColor(row: indexPath.row)
        cell.textLabel.text = dateManager.conversionDateFormat(row: indexPath.row, startDate: self.startDate)
        cell.tag = dateManager.tagForCell(date: date)

//        if (dateAttributes.existPosts(dayLabel: cell.textLabel.text!)) {
//            // 投稿があった日は太字 + 色を黒くする
//            cell.textLabel.font = UIFont(name: "HiraKakuProN-W6", size: 11.5)
//            cell.textLabel.textColor = UIColor.black
//        }

//        if (prevDay == cell.textLabel.text) {
//            cell.circleImageView.image = UIImage(named: "circle")
//            prevIndexPath = indexPath
//        }
//        if (prevIndexPath != nil) {                                 // Deselectの役割
//            let cell: CalendarCell = collectionView.cellForItem(at: prevIndexPath!)! as! CalendarCell
//            cell.circleImageView.image = nil
//        }
//        cell.circleImageView.image = UIImage(named: "circle")
        return cell
    }

    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length: CGFloat = (collectionView.frame.size.width) / CGFloat(daysPerWeek)

        appDelegate.calendarCellWidth = length
        appDelegate.calendarCellHeight = length
        
        return CGSize(width: length, height: length)
    }

    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // cellをtapした直後のアクション
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if (dateManager.ShowDayIfInThisMonth(indexPath.row) != "") {    // 数字の部分にのみ処理を行う
//        if (prevIndexPath != nil) {                                 // Deselectの役割
//            let cell: CalendarCell = collectionView.cellForItem(at: prevIndexPath!)! as! CalendarCell
//            cell.circleImageView.image = nil
//        }
        addCircleToCell(collectionView, indexPath: indexPath)
//        }
        
//        let day: String = dateManager.ShowDayIfInThisMonth(indexPath.row)
//        if (day != "") {
//            let year: String = (appDelegate.targetDate?.components(separatedBy: "-")[0])!
//            let month: String = (appDelegate.targetDate?.components(separatedBy: "-")[1])!
//            appDelegate.targetDate = year + "-" + month + "-" + day
//
//            NotificationCenter.default.post(name: TapCalendarCellNotification, object: nil)
//        }
    }

    //headerの月を変更
    func changeHeaderTitle(_ date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let selectMonth: String = formatter.string(from: date)
        formatter.dateFormat = "yyyy-MM"
        let Month4Calc: String = formatter.string(from: date)
        updateTargetDate(date: Month4Calc)
        return selectMonth
    }

    // 月が変更する際に、appDelegate側の変数も更新する
    func updateTargetDate(date: String) {
        let day: String = (self.appDelegate.targetDate?.components(separatedBy: "-")[2])!
        appDelegate.targetDate = date + "-" + day
        NotificationCenter.default.post(name: TapCalendarCellNotification, object: nil)
    }

    // 選択されたセルに円を付与する
    func addCircleToCell(_ collectionView: UICollectionView, indexPath: IndexPath) {
        let cell: CalendarCell = collectionView.cellForItem(at: indexPath)! as! CalendarCell
        cell.circleImageView.image = UIImage(named: "circle")
        prevDay = cell.textLabel.text
        prevIndexPath = indexPath
    }
}
