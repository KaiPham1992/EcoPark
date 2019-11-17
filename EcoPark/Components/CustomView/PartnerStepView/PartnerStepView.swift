//
//  PartnerStepView.swift
//  EnglishApp
//
//  Created by Tu DV on 10/31/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class PartnerStepView: BaseViewXib {

    @IBOutlet weak var lbPartnerInfo: UILabel!
    @IBOutlet weak var lbParkingInfo: UILabel!
    @IBOutlet weak var lbOtherInfo: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var imgSpace1: UIImageView!
    @IBOutlet weak var imgSpace2: UIImageView!
    @IBOutlet weak var btnStep1: UIButton!
    @IBOutlet weak var btnStep2: UIButton!
    @IBOutlet weak var btnStep3: UIButton!
    
    override func setUpViews() {
        lbPartnerInfo.text = LocalizableKey.juridicalInfomation.showLanguage
        lbParkingInfo.text = LocalizableKey.parkingInfomation.showLanguage
        lbOtherInfo.text = LocalizableKey.otherInfomation.showLanguage
    }

    func setStep1() {
        img2.image = AppImage.iconNumber2_off
        img3.image = AppImage.iconNumber3_off
        imgSpace1.image = AppImage.iconSpace_off
        imgSpace2.image = AppImage.iconSpace_off
        
        lbPartnerInfo.textColor = AppColor.color_0_129_255
        lbParkingInfo.textColor = AppColor.color_112_112_112
        lbOtherInfo.textColor = AppColor.color_112_112_112
    }
    
    func setStep2() {
        img2.image = AppImage.iconNumber2_on
        img3.image = AppImage.iconNumber3_off
        imgSpace1.image = AppImage.iconSpace_on
        imgSpace2.image = AppImage.iconSpace_off
        
        lbPartnerInfo.textColor = AppColor.color_0_129_255
        lbParkingInfo.textColor = AppColor.color_0_129_255
        lbOtherInfo.textColor = AppColor.color_112_112_112
    }
    
    func setStep3() {
        img2.image = AppImage.iconNumber2_on
        img3.image = AppImage.iconNumber3_on
        imgSpace1.image = AppImage.iconSpace_on
        imgSpace2.image = AppImage.iconSpace_on
        
        lbPartnerInfo.textColor = AppColor.color_0_129_255
        lbParkingInfo.textColor = AppColor.color_0_129_255
        lbOtherInfo.textColor = AppColor.color_0_129_255
    }
}
