//
//  PriceAddMoneyCell.swift
//  EcoPark
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class PriceAddMoneyCell: UITableViewCell {
    @IBOutlet weak var DLVBillForHour: DoubleLabelView!
    @IBOutlet weak var DLVBillFor8Hour: DoubleLabelView!
    @IBOutlet weak var DLVNumberParking: DoubleLabelView!
    @IBOutlet weak var DLVMoneyPayment: DoubleLabelView!
    @IBOutlet weak var DLVPriceParking: DoubleLabelView!
    @IBOutlet weak var DLVAddForWallet: DoubleLabelView!
    @IBOutlet weak var DLVAddForMoney: DoubleLabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        DLVBillForHour.setupViewUnit(title: LocalizableKey.priceAHours.showLanguage + ":")
        DLVBillFor8Hour.setupViewUnit(title: LocalizableKey.priceCombo.showLanguage + ":")
        DLVNumberParking.setupViewUnit(title: LocalizableKey.NumberHoursSend.showLanguage + ":")
        DLVMoneyPayment.setupViewUnit(title: LocalizableKey.parkingFeeUser.showLanguage + ":")
        DLVPriceParking.setupViewUnit(title: LocalizableKey.Paid.showLanguage + ":")
        DLVAddForWallet.setupViewUnit(title: LocalizableKey.paidWithWallet.showLanguage + ":")
        DLVAddForMoney.setupViewUnitColorRed(title: LocalizableKey.paidWithCash.showLanguage + ":")
    }
}
