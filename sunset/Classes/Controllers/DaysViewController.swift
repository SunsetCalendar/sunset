import UIKit

class DaysViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let weekArray: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = -9.0
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var daysCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        daysCollectionView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.clear

        daysCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath) as! CalendarCell

        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.red
        } else if (indexPath.row % 7 == 6) {
            cell.textLabel.textColor = UIColor.blue
        } else {
            cell.textLabel.textColor = UIColor.white
        }

        cell.textLabel.text = weekArray[indexPath.row]
        cell.textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 10.0)
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.size.width) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 0.6

        appDelegate.calendarCellWidth = width
        appDelegate.calendarCellHeight = height

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
