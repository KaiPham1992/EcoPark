//
//  AppRatingView.swift
//  Oganban
//
//  Created by Kai Pham on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class AppRatingView: BaseViewXib {
    var number: CGFloat = 1.5
    @IBOutlet weak var vStackView: UIStackView!
    
    @IBAction func btnActionTapped(sender: UIButton) {
        number = CGFloat(sender.tag)
        setStar(number: number)
    }
    
    override func setUpViews() {
        setStar(number: number)
    }
    
    func setStar(number: CGFloat) {
        self.number = number
        
        let intNumber = Int(number)
        
        for (index, subView) in vStackView.arrangedSubviews.enumerated() {
            if let btn = subView as? UIButton {
                if btn.tag <= intNumber {
                    btn.setImage(AppImage.imgStarFilled, for: .normal)
                } else {
                    if number - CGFloat(intNumber) > 0 {
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
