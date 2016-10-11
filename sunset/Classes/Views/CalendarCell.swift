import UIKit

class CalendarCell: UICollectionViewCell {

    @IBOutlet weak var hexImageView: UIImageView!

    var textLabel: UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // セルの大きさに合わせて文字の中央揃えを設定させる
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: appDelegate.calendarCellWidth!, height: appDelegate.calendarCellHeight!))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 11.5)
        textLabel.textAlignment = NSTextAlignment.center

        // Cellに追加
        self.addSubview(textLabel!)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func prepareForReuse() {
        self.hexImageView.image = nil
        self.textLabel.font = UIFont(name: "HirakakuProN-W3", size: 11.5)
    }
}
