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
    @IBOutlet weak var lbTypeName: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    
    var parking: ParkingEntity? {
        didSet {
            guard let parking = parking else { return }
            lbDetail.text = LocalizableKey.Detail.showLanguage + " >>"
            btnBooking.setTitle(LocalizableKey.Booking.showLanguage, for: .normal)
            lbName.text = parking.parking_name
            lbTypeName.text = parking.parking_type_name
            
            if let price = parking.price {
                let hour = price > 1 ? LocalizableKey.Hour.showLanguage: LocalizableKey.Hours.showLanguage
                lbPrice.text = price.toCurrency + "/ \(hour)"
            }
            
            if let packagePrice = parking.package_price {
                let numberHours = UserDefaultHelper.shared.numberHours
                let hour = packagePrice > 1 ? LocalizableKey.hour.showLanguage: LocalizableKey.Hour.showLanguage
                lbPackagePrice.text = "\(packagePrice.toCurrency)" + "/ \(LocalizableKey.Package.showLanguage) " + "\(numberHours)" + " \(hour)"
            }
            
            if let rating = parking.rating {
                vRating.setStar(number: rating)
            } else {
                vRating.setStar(number: 0.0)
            }
            
            lbConfigure.text = parking.config_price?.toCurrency
            
            lbMaximum.text = "\(LocalizableKey.maxPlaceParking.showLanguage): " + parking.number_place& + " \(LocalizableKey.slot.showLanguage)"
            
            let attr = NSMutableAttributedString()
            let attr1 = "\(LocalizableKey.TimeAction.showLanguage): ".toAttributedString(color: AppColor.color_102_102_102, font: AppFont.fontRegular15, isUnderLine: false)
            attr.append(attr1)
            
            if let timeStart = parking.time_start?.toString(dateFormat: AppDateFormat.HHmm),
                let timeEnd = parking.time_end?.toString(dateFormat: AppDateFormat.HHmm) {
                let attr2 = "\(timeStart) - \(timeEnd)".toAttributedString(color: AppColor.color_13_196_68, font: AppFont.fontRegular15, isUnderLine: false)
                attr.append(attr2)
            }
            
            lbTime.attributedText = attr
            
            imgIcon.sd_setImage(with: parking.url, placeholderImage: AppImage.imgPlaceHolder)
            //            vRating.lbNumberRating.text = "(\(parking.total_rating&))"
            
            if parking.total_rating& != "" {
                vRating.lbNumberRating.text = "(\(parking.total_rating&))"
            } else {
                vRating.lbNumberRating.text = ""
            }
        }
    }
}
