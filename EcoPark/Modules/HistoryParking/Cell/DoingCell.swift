//
//  DoingCell.swift
//  EcoPark
//
//  Created by Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class DoingCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var DLVBook: DoubleLabelView!
    @IBOutlet weak var DLVCheckin: DoubleLabelView!
    @IBOutlet weak var DLVCheckout: DoubleLabelView!
    @IBOutlet weak var lblPayment: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        DLVBook.setupViewForHistory(title: LocalizableKey.book_at.showLanguage)
        DLVCheckin.setupViewForHistory(title: "Check in")
        DLVCheckout.setupViewForHistory(title: "Check out")
        lbTotal.text = LocalizableKey.total.showLanguage
    }
    
    func setupCell(data: HistoryBookingParkingResponse) {
        lblCode.text = data.code
        let status = data.status ?? ""
        switch status {
        case StatusBooking.cancel.rawValue:
            lblStatus.text = LocalizableKey.cancelBooking.showLanguage
            lblStatus.textColor = UIColor.red
            DLVCheckin.lblTime.text = "-"
            DLVCheckout.lblTime.text = "-"
        case StatusBooking.checked_out.rawValue:
            lblStatus.text = LocalizableKey.checked_out.showLanguage
            lblStatus.textColor = AppColor.color_0_129_255
            DLVCheckin.lblTime.text = data.time_check_in?.toString(dateFormat: AppDateFormat.ecoTime) ?? "-"
            DLVCheckout.lblTime.text = data.time_check_out?.toString(dateFormat: AppDateFormat.ecoTime) ?? "-"
        case StatusBooking.checked_in.rawValue:
            lblStatus.text = LocalizableKey.checked_in.showLanguage
            lblStatus.textColor = AppColor.color_13_196_68
            DLVCheckin.lblTime.text = data.time_check_in?.toString(dateFormat: AppDateFormat.ecoTime) ?? "-"
            DLVCheckout.lblTime.text = "-"
        case StatusBooking.reservation.rawValue:
            lblStatus.text = LocalizableKey.reservation.showLanguage
            lblStatus.textColor = AppColor.color_255_145_0
            DLVCheckin.lblTime.text = "-"
            DLVCheckout.lblTime.text = "-"
        case StatusBooking.expired.rawValue:
            lblStatus.text = LocalizableKey.expired.showLanguage
            DLVCheckin.lblTime.text = data.intend_checkin_time?.toString(dateFormat: AppDateFormat.ecoTime) ?? "-"
            DLVCheckout.lblTime.text = data.intend_checkout_time?.toString(dateFormat: AppDateFormat.ecoTime) ?? "-"
            lblStatus.textColor = UIColor.red
        default:
            break
        }
        lblAddress.text = data.parking_details?.name ?? ""
        DLVBook.lblTime.text = data.create_time?.toString(dateFormat: AppDateFormat.ecoTime) ?? "-"
        lblPayment.text = (data.money_paid?.toCurrency ?? "")
    }
}
