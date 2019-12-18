//
//  SelectCarPopUpContent.swift
//  EcoPark
//
//  Created by Ngoc Duong on 12/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class SelectCarPopUpContent: BaseView {
    @IBOutlet weak var imgCar4: UIImageView!
    @IBOutlet weak var imgCar7: UIImageView!
    @IBOutlet weak var lbCar4: UILabel!
    @IBOutlet weak var lbCar7: UILabel!
    
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn7: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        
        imgCar4.image = AppImage.imgCar4
        imgCar4.tintColor = AppColor.color_0_129_255
        lbCar4.textColor = AppColor.color_0_129_255
        
        imgCar7.image = AppImage.imgCar7
        imgCar7.tintColor = AppColor.color_205_205_205
        lbCar7.textColor = AppColor.color_205_205_205
    }
    
}



