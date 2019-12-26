//
//  PriceCheckoutCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/21/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class PriceCheckoutCell: UITableViewCell {

    @IBOutlet weak var lbPriceAHours: UILabel!
    @IBOutlet weak var lbPriceACombo: UILabel!
    @IBOutlet weak var lbTimeHolding: UILabel!
    @IBOutlet weak var lbPriceParking: UILabel!
    @IBOutlet weak var lbPaid: UILabel!
    @IBOutlet weak var lbPaidWithWallet: UILabel!
    @IBOutlet weak var lbPaidWithCash: UILabel!
    @IBOutlet weak var lbPriceAHoursPrice: UILabel!
    @IBOutlet weak var lbPriceComboPrice: UILabel!
    @IBOutlet weak var lbHoldingTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lbPaidPrice: UILabel!
    @IBOutlet weak var lbPaidWithWalletPrice: UILabel!
    @IBOutlet weak var lbPaidWithCashPrice: UILabel!
    
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
        
        self.lbPriceAHoursPrice.text = _historyParkingDetail.price
        self.lbPriceComboPrice.text = _historyParkingDetail.package_price
//        self.lbHoldingTime.text = _historyParkingDetail.
        self.lblPrice.text = _historyParkingDetail.price
        self.lbPaidPrice.text = "\(_historyParkingDetail.money_paid ?? 0)"
        self.lbPaidWithWalletPrice.text = "\(_historyParkingDetail.payment_wallet ?? 0)"
        self.lbPaidWithCashPrice.text = "\(_historyParkingDetail.payment ?? 0)"
    }
    
}
