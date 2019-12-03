//
//  PaymentPopUpContent.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class PaymentPopUpContent: BaseViewXib {
    @IBOutlet weak var lbNeedToPay: UILabel!
    @IBOutlet weak var lbEcoAccount: UILabel!
    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var lbTitleNeedToPay: UILabel!
    @IBOutlet weak var lbTitleEcoAccount: UILabel!
    @IBOutlet weak var lbTitleCash: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
        lbTitleNeedToPay.text = LocalizableKey.titleNeedToPay.showLanguage
        lbTitleEcoAccount.text = LocalizableKey.titleEcoAccount.showLanguage
        lbTitleCash.text = LocalizableKey.titleCash.showLanguage
        btnPay.setTitle(LocalizableKey.payAndCheckout.showLanguage, for: .normal)
    }
}
