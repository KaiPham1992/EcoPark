//
//  PriceCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var lbPriceAHours: UILabel!
    @IBOutlet weak var lbPriceACombo: UILabel!
    @IBOutlet weak var lbHoldingTime: UILabel!
    @IBOutlet weak var lbPriceParking: UILabel!
    @IBOutlet weak var lbPriceAHoursPrice: UILabel!
    @IBOutlet weak var lbPriceComboPrice: UILabel!
    @IBOutlet weak var lbTimeHolding: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let numberHours = UserDefaultHelper.shared.numberHours
        lbPriceAHours.text = LocalizableKey.priceAHours.showLanguage + ":"
        lbPriceACombo.text = LocalizableKey.priceCombo.showLanguage + " \(numberHours) " + LocalizableKey.Hours.showLanguage + ":"
        lbHoldingTime.text = LocalizableKey.NumberHoursSend.showLanguage + ":"
        lbPriceParking.text = LocalizableKey.ParkingFee.showLanguage + ":"
        lbHour.text = LocalizableKey.hour.showLanguage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbPriceComboPrice.text = _historyParkingDetail.package_price?.toCurrencyNoVND
        lbPriceAHoursPrice.text = _historyParkingDetail.price?.toCurrencyNoVND
        lbTimeHolding.text = "0"
        lblPrice.text = "0"
    }
    
    func setDataBooking(historyParkingDetail: HistoryBookingParkingResponse?) {
            guard let _historyParkingDetail = historyParkingDetail else { return }
        lbPriceComboPrice.text = _historyParkingDetail.package_price?.toCurrencyNoVND
        lbPriceAHoursPrice.text = _historyParkingDetail.price?.toCurrencyNoVND
            lbTimeHolding.text = "0"
            lblPrice.text = "0"
        }
}
