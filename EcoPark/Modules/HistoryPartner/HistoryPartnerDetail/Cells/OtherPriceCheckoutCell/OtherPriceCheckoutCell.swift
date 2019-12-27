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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbRealPaidPrice.text = _historyParkingDetail.real_money?.toCurrencyNoVND
            lbBonusEcoPrice.text = _historyParkingDetail.bonus?.toCurrencyNoVND
        lbPaidWithWalletPrice.text = _historyParkingDetail.customer_payment_wallet?.toCurrencyNoVND
        lbPaidWithCashPrice.text = _historyParkingDetail.payment?.toCurrencyNoVND
        lbWalletChangePrice.text = "+" +  (_historyParkingDetail.plus_wallet_boss?.toCurrencyNoVND ?? "0")
        
    }
    
}
