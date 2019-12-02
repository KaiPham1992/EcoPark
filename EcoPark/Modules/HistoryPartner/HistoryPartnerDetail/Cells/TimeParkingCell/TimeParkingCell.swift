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
    
    var checkinTime: TimeInterval = 0
    
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
        
        vDay.setupTitle(title: LocalizableKey.date.showLanguage)
        vHour.setupTitle(title: LocalizableKey.hour.showLanguage)
        vMinute.setupTitle(title: LocalizableKey.minute.showLanguage)
        
        setupTimeCount()
        
    }
    
    func setupTimeCount() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            
            let ddhhmm = Utils.getTime(date: self.checkinTime)
            
            var minute = (ddhhmm.2).digits
            var hour = (ddhhmm.1).digits
            var day = (ddhhmm.0).digits
            
            if minute.count < 2 {
                minute = [0, minute[0]]
                self.minuteTwo = minute[1]
                self.minuteOne = minute[0]
                
                self.vMinute.lblTwo.text = "\(self.minuteTwo)"
                self.vMinute.lblOne.text = "\(self.minuteOne)"
                
            } else {
                self.minuteTwo = minute[1]
                self.minuteOne = minute[0]
                
                self.vMinute.lblTwo.text = "\(self.minuteTwo)"
                self.vMinute.lblOne.text = "\(self.minuteOne)"
            }
            
            if hour.count < 2 {
                hour = [0, hour[0]]
                self.hourTwo = hour[1]
                self.hourOne = hour[0]
                self.vHour.lblTwo.text = "\(self.hourTwo)"
                self.vHour.lblOne.text = "\(self.hourOne)"
            } else {
                self.minuteTwo = minute[1]
                self.minuteOne = minute[0]
                self.vHour.lblTwo.text = "\(self.hourTwo)"
                self.vHour.lblOne.text = "\(self.hourOne)"
            }
            
            if day.count > 2 {
                day = [9,9]
                self.dayTwo = day[1]
                self.dayOne = day[0]
                self.vDay.lblTwo.text = "\(self.dayTwo)"
                self.vDay.lblOne.text = "\(self.dayOne)"
            } else {
                self.dayTwo = day[1]
                self.dayOne = day[0]
                self.vDay.lblTwo.text = "\(self.dayTwo)"
                self.vDay.lblOne.text = "\(self.dayOne)"
            }
            
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
        
        
        guard let checkinTime = _historyParkingDetail.intend_checkin_time?.timeIntervalSince1970 else { return }
        
        self.checkinTime = checkinTime
        
    }
}

