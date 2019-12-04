//
//  CheckInPopUpContent.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CheckInPopUpContent: BaseViewXib {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var lbTimeExpect: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
        lbTimeExpect.text = LocalizableKey.timeExpect.showLanguage
        btnCancel.setTitle(LocalizableKey.cancel.showLanguage, for: .normal)
    }
}
