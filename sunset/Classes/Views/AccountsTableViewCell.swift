import UIKit

class AccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var checked: UILabel!
    @IBOutlet weak var accountInfo: UILabel!
    @IBOutlet weak var logoutButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
