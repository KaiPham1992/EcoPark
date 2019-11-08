//
//  ParkingSortView.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/28/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ParkingSortView: BaseViewXib {
    @IBOutlet weak var btnOver: UIButton!
    @IBOutlet weak var btnBooking: UIButton!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var vRating: AppRatingView!
    @IBOutlet weak var lbPackagePrice: UILabel!
    @IBOutlet weak var lbMaximum: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbConfigure: UILabel!
    
    var parking: ParkingEntity? {
        didSet {
            guard let parking = parking else { return }
            lbName.text = parking.parking_name
            
           
            if let price = parking.price {
                lbPrice.text = price& + "/ giờ"
            }
            
            if let packagePrice = parking.package_price, let packageNumber = parking.package_number {
                lbPackagePrice.text = "\(packagePrice.toCurrency)" + "/ gói " + Int(packageNumber).description + " giờ"
            }
            
            if let rating = parking.rating {
                 vRating.setStar(number: rating)
            }
            
            lbConfigure.text = parking.config_price?.toCurrency
            
            lbMaximum.text = "Sức chứa tối đa: " + parking.number_place& + " chỗ"
            
            let attr = NSMutableAttributedString()
            let attr1 = "Thời gian hoạt động: ".toAttributedString(color: AppColor.color_102_102_102, font: AppFont.fontRegular15, isUnderLine: false)
            attr.append(attr1)
            
            if let timeStart = parking.time_start?.toString(dateFormat: AppDateFormat.HHmm),
                let timeEnd = parking.time_end?.toString(dateFormat: AppDateFormat.HHmm) {
                let attr2 = "\(timeStart) - \(timeEnd)".toAttributedString(color: AppColor.color_13_196_68, font: AppFont.fontRegular15, isUnderLine: false)
                attr.append(attr2)
            }
            
            lbTime.attributedText = attr
           
        }
    }
}
