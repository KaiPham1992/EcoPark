//
//  HomeFilterPopUpContentView.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/28/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HomeFilterPopUpContentView: BaseViewXib {
    
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lbMaxDistance: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var starView: ParkingLevelView!
    
    var distance = 1000

    override func setUpViews() {
        slider.maximumValue = 1000
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.distance = Int(sender.value)
    }
    
}
