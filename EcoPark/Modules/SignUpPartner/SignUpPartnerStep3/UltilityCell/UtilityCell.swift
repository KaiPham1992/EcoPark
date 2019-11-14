//
//  UtilityCell.swift
//  EnglishApp
//
//  Created by Tu DV on 10/31/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class UtilityCell: UICollectionViewCell {
    
    @IBOutlet weak var imgItem: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(isSelect: Bool, index: Int) {
        switch index {
        case 0:
            imgItem.image = isSelect ? UIImage(named: "ic_roof_on") : UIImage(named: "ic_roof_off")
        case 1:
            imgItem.image = isSelect ? UIImage(named: "ic_carwash_on") : UIImage(named: "ic_carwash_off")
        case 2:
            imgItem.image = isSelect ? UIImage(named: "ic_repair_on") : UIImage(named: "ic_repair_off")
        case 3:
            imgItem.image = isSelect ? UIImage(named: "ic_rent_on") : UIImage(named: "ic_rent_off")
        case 4:
            imgItem.image = isSelect ? UIImage(named: "ic_supermarket_on") : UIImage(named: "ic_supermarket_off")
        case 5:
            imgItem.image = isSelect ? UIImage(named: "ic_atm_on") : UIImage(named: "ic_atm_off")
        case 6:
            imgItem.image = isSelect ? UIImage(named: "ic_hotel_on") : UIImage(named: "ic_hotel_off")
        case 7:
            imgItem.image = isSelect ? UIImage(named: "ic_coffee_on") : UIImage(named: "ic_coffee_off")
        default:
            return
        }
    }
    
}
