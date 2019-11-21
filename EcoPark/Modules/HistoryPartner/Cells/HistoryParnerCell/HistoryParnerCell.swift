//
//  HistoryParnerCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HistoryParnerCell: UITableViewCell {

    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNumberCar: UILabel!
    @IBOutlet weak var lbBooking: UILabel!
    @IBOutlet weak var lbBookingTime: UILabel!
    @IBOutlet weak var lbExpect: UILabel!
    @IBOutlet weak var lbExpectTime: UILabel!
    @IBOutlet weak var lbCheckIn: UILabel!
    @IBOutlet weak var lbCheckInTime: UILabel!
    @IBOutlet weak var lbCheckOut: UILabel!
    @IBOutlet weak var lbCheckoutTime: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    func setDataBookingHistory() {
        btnStatus.backgroundColor = .clear
        btnStatus.setTitleColor(.orange, for: .normal)
        btnStatus.setTitle("Đang giữ chỗ", for: .normal)
    }
    
    func setDataHistory(historyParking: BookingEntity?) {
        guard let _historyParking = historyParking else { return }
        lbName.text = _historyParking.fullname
        lbBookingTime.text = _historyParking.create_time?.toString(dateFormat: AppDateFormat.hhmmddmmyyy)
        lbExpectTime.text = _historyParking.update_time?.toString(dateFormat: .hhmmddmmyyy)
        lbCheckInTime.text = _historyParking.intend_checkin_time?.toString(dateFormat: .hhmmddmmyyy)
        lbCheckoutTime.text = _historyParking.intend_checkout_time?.toString(dateFormat: .hhmmddmmyyy)
        lbNumberCar.text = _historyParking.license_plates
        lbID.text = _historyParking.code
        lbPrice.text = "\(_historyParking.money_paid ?? 0)"
    }
}
