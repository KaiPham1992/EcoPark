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
}
