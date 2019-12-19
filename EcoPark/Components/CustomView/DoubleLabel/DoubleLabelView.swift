//
//  DoubleLabelView.swift
//  EcoPark
//
//  Created by Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class DoubleLabelView : BaseViewXib {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    override func setUpViews() {
    }
    
    func setupViewForTitle(title: String) {
        lblTitle.text = title
        lblTitle.textColor = #colorLiteral(red: 0, green: 0.5058823529, blue: 1, alpha: 1)
        lblTime.textColor = #colorLiteral(red: 0.05098039216, green: 0.768627451, blue: 0.2666666667, alpha: 1)
    }
    
    func setupViewForHistory(title: String) {
        lblTitle.text = title
        lblTitle.textColor = AppColor.color_169_169_169
        lblTitle.font = AppFont.fontRegular15
        lblTime.textColor = AppColor.color40_50_75
        lblTitle.font = AppFont.fontRegular13
    }
    
    func setupViewTimeBlue(title: String) {
        lblTime.textColor = #colorLiteral(red: 0, green: 0.5058823529, blue: 1, alpha: 1)
        lblTitle.text = title
    }
    
    func setupViewTimeBold(title: String) {
        lblTime.font = AppFont.fontBold17
        lblTitle.text = title
    }
    
    func setValueText(text: String) {
        lblTime.text = text
    }
    
    func setupViewUnit(title: String, value: String = "0", unit: String = "VND") {
        let attribute = NSMutableAttributedString()
        let attr1 = NSAttributedString(string: value, attributes: [NSAttributedString.Key.font : AppFont.fontRegular15, NSAttributedString.Key.foregroundColor: UIColor.black])
        let attr2 = NSAttributedString(string: " " + unit, attributes: [NSAttributedString.Key.font : AppFont.fontRegular15, NSAttributedString.Key.foregroundColor: AppColor.color158_158_158])
        attribute.append(attr1)
        attribute.append(attr2)
        lblTime.attributedText = attribute
        lblTitle.text = title
    }
    
    func setupViewUnitColorRed(title: String, value: String = "0", unit: String = "VND") {
        let attribute = NSMutableAttributedString()
        let attr1 = NSAttributedString(string: value, attributes: [NSAttributedString.Key.font : AppFont.fontRegular15, NSAttributedString.Key.foregroundColor: UIColor.red])
        let attr2 = NSAttributedString(string: " " + unit, attributes: [NSAttributedString.Key.font : AppFont.fontRegular15, NSAttributedString.Key.foregroundColor: UIColor.red])
        attribute.append(attr1)
        attribute.append(attr2)
        lblTime.attributedText = attribute
        lblTitle.text = title
    }
}
