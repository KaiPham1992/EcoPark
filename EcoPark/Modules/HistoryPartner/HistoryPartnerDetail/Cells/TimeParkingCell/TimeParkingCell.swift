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
    
    @IBOutlet weak var vDay: TimeView!
    @IBOutlet weak var vHour: TimeView!
    @IBOutlet weak var vMinute: TimeView!
    
    var timer: Timer?
    var minuteOne = 0
    var minuteTwo = 0
    var hourTwo = 0
    var hourOne = 0
    var dayOne = 0
    var dayTwo = 0
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
        
        vDay.setupTitle(title: "Ngày")
        vHour.setupTitle(title: "Giờ")
        vMinute.setupTitle(title: "Phút")
        
        setupTimeCount()
        
    }
    
    func setupTimeCount() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.minuteTwo += 1
            self.vMinute.lblTwo.text = "\(self.minuteTwo)"
            
            if self.minuteTwo > 9 {
                self.minuteTwo = 0
                self.minuteOne += 1
                self.vMinute.lblTwo.text = "\(self.minuteTwo)"
                self.vMinute.lblOne.text = "\(self.minuteOne)"
                
                if self.minuteOne > 5 {
                    self.minuteTwo = 0
                    self.minuteOne = 0
                    self.hourTwo += 1
                    self.vMinute.lblOne.text = "\(self.minuteOne)"
                    self.vHour.lblTwo.text = "\(self.hourTwo)"
                    
                    if self.hourTwo > 9 {
                        self.hourTwo = 0
                        self.hourOne += 1
                        self.vHour.lblTwo.text = "\(self.hourTwo)"
                        self.vHour.lblOne.text = "\(self.hourOne)"
                    }
                    
                    if self.hourOne == 2 && self.hourTwo == 4 {
                        self.hourOne = 0
                        self.hourTwo = 0
                        self.dayTwo += 1
                        self.vHour.lblTwo.text = "\(self.hourTwo)"
                        self.vHour.lblOne.text = "\(self.hourOne)"
                        self.vHour.lblTwo.text = "\(self.hourTwo)"
                        self.vDay.lblTwo.text = "\(self.dayTwo)"
                        
                        if self.dayTwo > 9 {
                            self.dayTwo = 0
                            self.dayOne += 1
                            self.vDay.lblTwo.text = "\(self.dayTwo)"
                            self.vDay.lblOne.text = "\(self.dayOne)"
                        }
                    }
                }
            }
        })
    }
    
    func setData(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbBookingTime.text = _historyParkingDetail.create_time?.toString(dateFormat: .hhmmddmmyyy)
        lbExpectTime.text = _historyParkingDetail.update_time?.toString(dateFormat: .hhmmddmmyyy)
        lbCheckInTime.text = _historyParkingDetail.intend_checkin_time?.toString(dateFormat: .hhmmddmmyyy)
        lbCheckOutTime.text = _historyParkingDetail.intend_checkout_time?.toString(dateFormat: .hhmmddmmyyy)
    }
}
