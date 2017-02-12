//
//  AccountsTableViewCell.swift
//  sunset
//
//  Created by Homma Takuma on 2017/01/09.
//  Copyright © 2017年 GMO Pepabo. All rights reserved.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var checked: UILabel!
    @IBOutlet weak var accountInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
