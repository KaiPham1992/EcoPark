//
//  YesNoContentView.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class ParkingDetailContent: BaseViewXib {
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        btnNo.setTitle(LocalizableKey.cancel.showLanguage, for: .normal)
        btnYes.setTitle(LocalizableKey.agree.showLanguage, for: .normal)
        lbTitle.text = LocalizableKey.bookingParkingDetail.showLanguage
    }
}
