//
//  UserInfoCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var lbUserInfo: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbCarType: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbCarNumber: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
