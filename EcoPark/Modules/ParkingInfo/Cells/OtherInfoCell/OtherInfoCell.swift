//
//  OtherInfoCell.swift
//  EcoPark_Dev
//
//  Created by Tu DV on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class OtherInfoCell: UITableViewCell {

    @IBOutlet weak var lbCapacity: UILabel!
    @IBOutlet weak var lbNumberCapacity: UILabel!
    @IBOutlet weak var lbItem: UILabel!
    @IBOutlet weak var lbAHours: UILabel!
    @IBOutlet weak var lbPriceAHours: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCombo: UILabel!
    @IBOutlet weak var lbPriceCombo: UILabel!
    @IBOutlet weak var lbTimeCombo: UILabel!
    
    var numberHours = "" {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        lbCapacity.text = LocalizableKey.capacity.showLanguage
        lbAHours.text = LocalizableKey.hoursPrice.showLanguage
        lbCombo.text = LocalizableKey.comboPrice.showLanguage
        
        lbItem.text = LocalizableKey.place.showLanguage
        lbTime.text = LocalizableKey.vndHours.showLanguage
        lbTimeCombo.text = "VND/ \(numberHours) " + LocalizableKey.hour.showLanguage
    }
    
    func setData(parkingInfo: ParkingInfoEntity?) {
        lbNumberCapacity.text = "\(parkingInfo?.number_place ?? 0)"
        lbPriceAHours.text = "\(parkingInfo?.price?.toCurrencyNoVND ?? "0")"
        lbPriceCombo.text = "\(parkingInfo?.package_price?.toCurrencyNoVND ?? "0")"
    }
    
}
