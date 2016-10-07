import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var hexImageView: UIImageView!
    
    var textLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
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
    }
}
