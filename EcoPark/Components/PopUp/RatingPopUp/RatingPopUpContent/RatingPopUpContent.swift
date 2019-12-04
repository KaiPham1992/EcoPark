//
//  RatingPopUpContent.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Cosmos
class RatingPopUpContent: BaseViewXib {
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lbRating: UILabel!
    
    override func setUpViews() {
        
        lbRating.text = LocalizableKey.rating.showLanguage
        let attr1 = LocalizableKey.contentRating1.toAttributedString(color: AppColor.black, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr2 = LocalizableKey.termAndPolicyText6.showLanguage.description.toAttributedString(color: AppColor.color_0_129_255, font: AppFont.fontBold15, isUnderLine: false)
        
        let attr3 = LocalizableKey.contentRating2.showLanguage.toAttributedString(color: AppColor.black, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        
        lbContent.attributedText = attr
    }
}
