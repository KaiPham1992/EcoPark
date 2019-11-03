//
//  PriceCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var lbPriceAHours: UILabel!
    @IBOutlet weak var lbPriceACombo: UILabel!
    @IBOutlet weak var lbTimeHolding: UILabel!
    @IBOutlet weak var lbPriceParking: UILabel!
    @IBOutlet weak var lbPriceAHoursPrice: UILabel!
    @IBOutlet weak var lbPriceComboPrice: UILabel!
    @IBOutlet weak var lbHoldingTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
