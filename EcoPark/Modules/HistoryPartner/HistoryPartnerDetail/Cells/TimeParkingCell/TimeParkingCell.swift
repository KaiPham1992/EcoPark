//
//  TimeParkingCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class TimeParkingCell: UITableViewCell {

    @IBOutlet weak var lbTimeBarking: UILabel!
    @IBOutlet weak var lbBooking: UILabel!
    @IBOutlet weak var lbExpect: UILabel!
    @IBOutlet weak var lbCheckIn: UILabel!
    @IBOutlet weak var lbCheckOut: UILabel!
    @IBOutlet weak var lbBookingTime: UILabel!
    @IBOutlet weak var lbExpectTime: UILabel!
    @IBOutlet weak var lbCheckInTime: UILabel!
    @IBOutlet weak var lbCheckOutTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupUI() {
    }
    
    func setData(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbBookingTime.text = _historyParkingDetail.create_time?.toString(dateFormat: .hhmmddmmyyy)
        lbExpectTime.text = _historyParkingDetail.update_time?.toString(dateFormat: .hhmmddmmyyy)
        lbCheckInTime.text = _historyParkingDetail.intend_checkin_time?.toString(dateFormat: .hhmmddmmyyy)
        lbCheckOutTime.text = _historyParkingDetail.intend_checkout_time?.toString(dateFormat: .hhmmddmmyyy)
    }
}
