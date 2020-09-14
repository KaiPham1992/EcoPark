//
//  OtherPriceCheckoutCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/21/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class OtherPriceCheckoutCell: UITableViewCell {

    @IBOutlet weak var lbRealPaid: UILabel!
    @IBOutlet weak var lbBonusEco: UILabel!
    @IBOutlet weak var lbPaidWithWallet: UILabel!
    @IBOutlet weak var lbPaidWithCash: UILabel!
    @IBOutlet weak var lbWalletChange: UILabel!
    @IBOutlet weak var lbRealPaidPrice: UILabel!
    @IBOutlet weak var lbBonusEcoPrice: UILabel!
    @IBOutlet weak var lbPaidWithWalletPrice: UILabel!
    @IBOutlet weak var lbPaidWithCashPrice: UILabel!
    @IBOutlet weak var lbWalletChangePrice: UILabel!
    
    
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
        lbRealPaid.text = LocalizableKey.realMoney.showLanguage + ":"
        lbBonusEco.text = LocalizableKey.bonusEco.showLanguage + ":"
        lbPaidWithWallet.text = LocalizableKey.KHPaidWallet.showLanguage + ":"
        lbPaidWithCash.text = LocalizableKey.KHPaidCash.showLanguage + ":"
        lbWalletChange.text = LocalizableKey.changeWallet.showLanguage + ":"
    }
    
    func setData(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbRealPaidPrice.text = _historyParkingDetail.real_money?.toCurrencyNoVND ?? "0"
            lbBonusEcoPrice.text = _historyParkingDetail.bonus?.toCurrencyNoVND ?? "0"
        lbPaidWithWalletPrice.text = _historyParkingDetail.customer_payment_wallet?.toCurrencyNoVND ?? "0"
        lbPaidWithCashPrice.text = _historyParkingDetail.payment?.toCurrencyNoVND ?? "0"
        lbWalletChangePrice.text =  _historyParkingDetail.plus_wallet_boss?.toCurrencyNoVND ?? "0"
        
    }
    
}
