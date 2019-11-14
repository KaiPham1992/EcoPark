//
//  AppRatingView.swift
//  Oganban
//
//  Created by Kai Pham on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class AppRatingView: BaseViewXib {
    var number: Double = 1.5
    
    @IBOutlet weak var vStackView: UIStackView!
    @IBOutlet weak var lbNumberRating: UILabel!

    
    @IBAction func btnActionTapped(sender: UIButton) {
        number = Double(sender.tag)
        setStar(number: number)
    }
    
    override func setUpViews() {
        setStar(number: number)
    }
    
    func setTitle(number: String) {
        self.lbNumberRating.isHidden = false
        self.lbNumberRating.text = number
    }
    
    func hideTitle() {
        self.lbNumberRating.isHidden = true
    }
    
    func setStar(number: Double) {
        self.number = number
        
        let intNumber = Int(number)
            
        for (index, subView) in vStackView.arrangedSubviews.enumerated() {
            if let btn = subView as? UIButton {
                if btn.tag <= intNumber {
                    btn.setImage(AppImage.imgStarFilled, for: .normal)
                } else {
                    if number - Double(intNumber) > 0 {
                        if intNumber == index {
                             btn.setImage(AppImage.imgStarHalf, for: .normal)
                        } else {
                             btn.setImage(AppImage.imgStarEmpty, for: .normal)
                        }
                    } else {
                        btn.setImage(AppImage.imgStarEmpty, for: .normal)
                    }
                }
            }
        }
    }
    
}
