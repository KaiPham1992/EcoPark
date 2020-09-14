//
//  RatingCell.swift
//  EcoPark
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Cosmos

class RatingCell: UITableViewCell {

    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var vRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbRating.text = LocalizableKey.ratingOfuser.showLanguage
    }
}
