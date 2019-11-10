//
//  YesNoContentView.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class BookingPopUpContent: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var btnDirection: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        
        lbTitle.text = LocalizableKey.bookingPopUpTitle.showLanguage
        btnDetail.setTitle(LocalizableKey.bookingPopUpDetail.showLanguage, for: .normal)
        btnDirection.setTitle(LocalizableKey.bookingPopUpDirect.showLanguage, for: .normal)
    }
}
