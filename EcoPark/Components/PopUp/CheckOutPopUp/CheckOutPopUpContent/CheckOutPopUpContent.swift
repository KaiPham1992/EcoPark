//
//  CheckOutPopUp.swift
//  EcoPark
//
//  Created by Tu DV on 1/10/20.
//  Copyright © 2020 demo. All rights reserved.
//

import UIKit

class CheckOutPopUpContent: BaseViewXib {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLicensePlate: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var lbTimeExpect: UILabel!
    @IBOutlet weak var lbTimeCheckout: UILabel!
    @IBOutlet weak var lbCheckoutTime: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
        lbTimeExpect.text = LocalizableKey.timeExpect.showLanguage
        lbTimeCheckout.text = LocalizableKey.timeCheckout.showLanguage
        btnCancel.setTitle(LocalizableKey.cancel.showLanguage, for: .normal)
    }
}
