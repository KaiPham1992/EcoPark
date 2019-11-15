//
//  LicenseInfoCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class LicenseInfoCell: UITableViewCell {

    @IBOutlet weak var vLicense: AppTextField!
    @IBOutlet weak var lbLicense: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vLicense.setTitleAndPlaceHolder(title: LocalizableKey.parkingTaxCode.showLanguage, placeHolder: "")
        lbLicense.text = LocalizableKey.parkingLicense.showLanguage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(parkingInfo: ParkingInfoEntity?) {
        vLicense.tfInput.text = parkingInfo?.code_tax
        image1.sd_setImage(with: parkingInfo?.url_gpkd_Before, completed: nil)
        image2.sd_setImage(with: parkingInfo?.url_gpkd_after, completed: nil)
    }
}
