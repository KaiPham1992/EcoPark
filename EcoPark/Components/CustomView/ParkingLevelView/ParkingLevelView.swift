//
//  ParkingLevelView.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/28/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ParkingLevelView: BaseViewXib {
    
    @IBOutlet var listButtonStar: [UIButton]!
    var star: [Int] = [1,2,3,4,5]
    
    @IBAction func btnFiveStarTapped() {
        star = [1,2,3,4,5]
    }
    
    @IBAction func btnFourStarTapped() {
        star = [1,2,3,4]
    }
    
    @IBAction func btnThreeStarTapped() {
        star = [1,2,3]
    }
    
    @IBAction func btnStarTapped(_ sender: UIButton) {
        for button in listButtonStar {
            if button == sender {
                button.backgroundColor = AppColor.color_0_129_255.withAlphaComponent(0.6)
            } else {
                button.backgroundColor = .white
            }
        }
    }
}

