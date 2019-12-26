//
//  TimeParkingCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class TimeParkingCell: UITableViewCell {
    
    @IBOutlet weak var lbTimeParking: UILabel!
    @IBOutlet weak var lbBooking: UILabel!
    @IBOutlet weak var lbExpect: UILabel!
    @IBOutlet weak var lbCheckIn: UILabel!
    @IBOutlet weak var lbCheckOut: UILabel!
    @IBOutlet weak var lbBookingTime: UILabel!
    @IBOutlet weak var lbExpectTime: UILabel!
    @IBOutlet weak var lbCheckInTime: UILabel!
    @IBOutlet weak var lbCheckOutTime: UILabel!
    
    @IBOutlet weak var vDay: TimeView!
    @IBOutlet weak var vHour: TimeView!
    @IBOutlet weak var vMinute: TimeView!
    
    var checkinTime: TimeInterval = 0
    var checkoutTime: TimeInterval = 0
    var newCurrentDate: Double = 0
    
    var timer: Timer?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func prepareForReuse() -> Void {
        timer = nil
    }
    deinit {
        timer?.invalidate()
    }
    
    private func setupUI() {
        lbTimeParking.text = LocalizableKey.parkingTimimg.showLanguage
        lbBooking.text = LocalizableKey.book_at.showLanguage
        lbExpect.text = LocalizableKey.expect.showLanguage
        vDay.setupTitle(title: LocalizableKey.date.showLanguage)
        vHour.setupTitle(title: LocalizableKey.hour.showLanguage)
        vMinute.setupTitle(title: LocalizableKey.minute.showLanguage)
        
    }
    
    func setupTimeCount() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.newCurrentDate = self.newCurrentDate + 1
            let ddhhmm = Utils.getTime(dateCheckIn: self.checkinTime, currentServerDate: self.newCurrentDate)
                       
            self.vHour.setUpTime(time: ddhhmm.1)
            self.vMinute.setUpTime(time: ddhhmm.2)
            self.vDay.setUpTime(time: ddhhmm.0)
        })
    }
    
    
    
    func setData(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbBookingTime.text = _historyParkingDetail.create_time?.toString(dateFormat: .ecoTime)
        lbExpectTime.text = _historyParkingDetail.update_time?.toString(dateFormat: .ecoTime)
        lbCheckInTime.text = _historyParkingDetail.time_check_in?.toString(dateFormat: .ecoTime)
        lbCheckOutTime.text = "-"
        
        
        guard let checkinTime = _historyParkingDetail.time_check_in?.timeIntervalSince1970 else { return }
        guard let current_server_time = _historyParkingDetail.current_server_time?.timeIntervalSince1970 else { return }
        self.newCurrentDate = current_server_time
        self.checkinTime = checkinTime
        setupTimeCount()
    }
    
    func setDataCheckout(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbBookingTime.text = _historyParkingDetail.create_time?.toString(dateFormat: .ecoTime)
        lbExpectTime.text = _historyParkingDetail.update_time?.toString(dateFormat: .ecoTime)
        lbCheckInTime.text = _historyParkingDetail.time_check_in?.toString(dateFormat: .ecoTime)
        lbCheckOutTime.text = _historyParkingDetail.time_check_out?.toString(dateFormat: .ecoTime)
        
        
        guard let checkinTime = _historyParkingDetail.time_check_in?.timeIntervalSince1970 else { return }
        guard let current_server_time = _historyParkingDetail.current_server_time?.timeIntervalSince1970 else { return }
        self.newCurrentDate = current_server_time
        self.checkinTime = checkinTime
    }
    
    func setDataBooking(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbBookingTime.text = _historyParkingDetail.create_time?.toString(dateFormat: .ecoTime)
        lbExpectTime.text = _historyParkingDetail.update_time?.toString(dateFormat: .ecoTime)
        lbCheckInTime.text = "-"
        lbCheckOutTime.text = "-"
        
        
        guard let checkinTime = _historyParkingDetail.time_check_in?.timeIntervalSince1970 else { return }
        guard let current_server_time = _historyParkingDetail.current_server_time?.timeIntervalSince1970 else { return }
        self.newCurrentDate = current_server_time
        self.checkinTime = checkinTime
        
    }
}

