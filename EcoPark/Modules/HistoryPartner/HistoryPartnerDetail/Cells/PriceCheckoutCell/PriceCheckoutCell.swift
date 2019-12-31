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
        
        self.lbPriceAHoursPrice.text = _historyParkingDetail.price?.toCurrencyNoVND
        self.lbPriceComboPrice.text = _historyParkingDetail.package_price?.toCurrencyNoVND
        self.lbHoldingTime.text = "\(_historyParkingDetail.numberHours ?? 0)"
        self.lblPrice.text = _historyParkingDetail.parking_price?.toCurrencyNoVND ?? "0"
        self.lbPaidPrice.text = _historyParkingDetail.money_paid?.toCurrencyNoVND ?? "0"
        self.lbPaidWithWalletPrice.text = historyParkingDetail?.payment_wallet?.toCurrencyNoVND ?? "0"
        self.lbPaidWithCashPrice.text = _historyParkingDetail.payment?.toCurrencyNoVND ?? "0"
        
        if historyParkingDetail?.status == StatusBooking.expired.rawValue || historyParkingDetail?.status == StatusBooking.cancel.rawValue {
            self.lblPrice.text = "0"
        }
    }
    
}
