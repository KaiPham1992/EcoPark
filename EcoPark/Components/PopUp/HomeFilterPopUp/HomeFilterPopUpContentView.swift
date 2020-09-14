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
    var distance = 500

    
    @IBOutlet weak var lbFilter: UILabel!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var lbLevel: UILabel!
    
    override func setUpViews() {
        // MARK: For slider
        slider.maximumValue = 500
        slider.value = 500
        
        // MARK: For star buttons
        lbDistance.text = LocalizableKey.FilterDistance.showLanguage
        lbFilter.text = LocalizableKey.FilterToolFilter.showLanguage
        lbLevel.text = LocalizableKey.ParkingLevel.showLanguage
        
        btnNo.setTitle(LocalizableKey.reset.showLanguage, for: .normal)
        btnYes.setTitle(LocalizableKey.apply.showLanguage, for: .normal)
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.distance = Int(sender.value)
    }
    
    @IBAction func btnResetTapped() {
        slider.value = 500
        distance = 500
        starView.resetAll()
    }
        
}
