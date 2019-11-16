//
//  ParkingLevelView.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/28/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ParkingLevelView: BaseViewXib {
    
    var star: [Int] = []
    
    @IBAction func btnFiveStarTapped() {
        star = [1,2,3,4,5]
    }
    
    @IBAction func btnFourStarTapped() {
        star = [1,2,3,4]
    }
    
    @IBAction func btnThreeStarTapped() {
        star = [1,2,3]
    }
}

