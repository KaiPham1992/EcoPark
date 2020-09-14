//
//  SelectCarPopUpContent.swift
//  EcoPark
//
//  Created by Ngoc Duong on 12/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class SelectCarPopUpContent: BaseViewXib {
    @IBOutlet weak var imgCar4: UIImageView!
    @IBOutlet weak var imgCar7: UIImageView!
    @IBOutlet weak var lbCar4: UILabel!
    @IBOutlet weak var lbCar7: UILabel!
    
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn7: UIButton!
    
    var isSelectIndex: Int = 0
    var listVehical = [VehicleTypeEntity]() {
        didSet {
            if listVehical.count > 1 {
                lbCar4.text = listVehical[0].name&
                lbCar7.text = listVehical[1].name&
                if isSelectIndex == 0 {
                    imgCar4.sd_setImage(with: listVehical[0].iconUrl)
                    imgCar7.sd_setImage(with: listVehical[1].iconUnsetUrl)
                    
                } else {
                    imgCar4.sd_setImage(with: listVehical[0].iconUnsetUrl)
                    imgCar7.sd_setImage(with: listVehical[1].iconUrl)
                }
            }
            
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
//        setStyle(indexSelected: 0)
    }
    
//    func setStyle(indexSelected: Int) {
//        if indexSelected == 0 {
//            imgCar4.image = AppImage.imgCar4
//            imgCar4.tintColor = AppColor.color_0_129_255
//            lbCar4.textColor = AppColor.color_0_129_255
//
//            imgCar7.image = AppImage.imgCar7
//            imgCar7.tintColor = AppColor.color_205_205_205
//            lbCar7.textColor = AppColor.color_205_205_205
//        } else {
//            imgCar7.image = AppImage.imgCar7
//            imgCar7.tintColor = AppColor.color_0_129_255
//            lbCar7.textColor = AppColor.color_0_129_255
//
//            imgCar4.image = AppImage.imgCar4
//            imgCar4.tintColor = AppColor.color_205_205_205
//            lbCar4.textColor = AppColor.color_205_205_205
//        }
//    }
    
}



