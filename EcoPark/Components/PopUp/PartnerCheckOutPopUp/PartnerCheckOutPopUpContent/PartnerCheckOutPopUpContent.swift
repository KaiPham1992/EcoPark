//
//  PartnerCheckOutPopUpContent.swift
//  EcoPark
//
//  Created by Henry on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class PartnerCheckOutPopUpContent: BaseViewXib {
    @IBOutlet weak var lbReceivable: UILabel!
    @IBOutlet weak var lbTypeCar: UILabel!
    @IBOutlet weak var lbLicensePlate: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbVehicleType: UILabel!
    @IBOutlet weak var lbVehicleNumber: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCheckAgain: UIButton!
    @IBOutlet weak var btnCheckOut: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        lbReceivable.text = LocalizableKey.receivable.showLanguage
        lbTypeCar.text = LocalizableKey.carType.showLanguage
        lbLicensePlate.text = LocalizableKey.licensePlate.showLanguage
        
        btnCancel.setTitle(LocalizableKey.cancel.showLanguage, for: .normal)
        btnCheckAgain.setTitle(LocalizableKey.checkAgain.showLanguage, for: .normal)
        btnCheckOut.setTitle(LocalizableKey.agreeCheckout.showLanguage, for: .normal)
    }
}
